package com.ssafy.daldong.exercise

import UserInfoViewModel
import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavHostController
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.google.android.gms.wearable.CapabilityClient
import com.google.android.gms.wearable.Node
import com.google.android.gms.wearable.Wearable
import com.ssafy.daldong.R
import com.ssafy.daldong.exercise.data.datastore.StoreUserManager
import com.ssafy.daldong.exercise.data.datastore.dataStore
import com.ssafy.daldong.exercise.presentation.ExerciseViewModel
import com.ssafy.daldong.exercise.presentation.ExerciseWearApp
import com.ssafy.daldong.exercise.presentation.InvalidUser
import com.ssafy.daldong.exercise.presentation.NoReachableNodes
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await

@AndroidEntryPoint
class MainActivity : ComponentActivity() {

    private lateinit var navController: NavHostController
    private lateinit var storeUserManager : StoreUserManager

    private val exerciseViewModel by viewModels<ExerciseViewModel>()

    // DataLayer API 객체
    private val dataClient by lazy { Wearable.getDataClient(this) }
    private val messageClient by lazy { Wearable.getMessageClient(this) }
    private val capabilityClient by lazy { Wearable.getCapabilityClient(this) }

    private val wearDataViewModel by viewModels<WearDataViewModel>()

    private val userInfoViewModel by viewModels<UserInfoViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        storeUserManager = StoreUserManager(dataStore) // 싱글톤

        lifecycleScope.launch {
            //주위에 도달할 노드 없는경우
            val destination = when (exerciseViewModel.isExerciseInProgress()) {
                false -> Screens.StartingUp.route
                true -> Screens.ExerciseScreen.route
            }

            setContent {
                navController = rememberSwipeDismissableNavController()

                ExerciseWearApp(
                    navController,
                    startDestination = destination,
                )
            }
        }
    }

    /**
     * Collects the capabilities for all nodes that are reachable using the [CapabilityClient].
     *
     * [CapabilityClient.getAllCapabilities] returns this information as a [Map] from capabilities
     * to nodes, while this function inverts the map so we have a map of [Node]s to capabilities.
     *
     * This form is easier to work with when trying to operate upon all [Node]s.
     */
    private suspend fun getCapabilitiesForReachableNodes(): Map<Node, Set<String>> =
        capabilityClient.getAllCapabilities(CapabilityClient.FILTER_REACHABLE)
            .await()
            // Pair the list of all reachable nodes with their capabilities
            .flatMap { (capability, capabilityInfo) ->
                capabilityInfo.nodes.map { it to capability }
            }
            // Group the pairs by the nodes
            .groupBy(
                keySelector = { it.first },
                valueTransform = { it.second }
            )
            // Transform the capability list for each node into a set
            .mapValues { it.value.toSet() }

    private fun displayNodes(nodes: Set<Node>) {
        val message = if (nodes.isEmpty()) {
            getString(R.string.no_device)
        } else {
            getString(R.string.connected_nodes, nodes.joinToString(", ") { it.displayName })
        }
        Log.d(TAG, "노드 상태 ${message.toString()}")
//        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    override fun onResume() {
        super.onResume()
        dataClient.addListener(wearDataViewModel)
        messageClient.addListener(wearDataViewModel)
        capabilityClient.addListener(
            wearDataViewModel,
            Uri.parse("wear://"),
            CapabilityClient.FILTER_REACHABLE
        )
    }

    override fun onPause() {
        super.onPause()
        dataClient.removeListener(wearDataViewModel)
        messageClient.removeListener(wearDataViewModel)
        capabilityClient.removeListener(wearDataViewModel)
    }

    companion object {
        private const val TAG = "워치 메인 액티비티"
        private val PET_INIT_PATH = "/PetInit"
    }
}
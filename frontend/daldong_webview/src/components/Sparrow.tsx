/*
Auto-generated by: https://github.com/pmndrs/gltfjsx
Command: npx gltfjsx@6.1.4 sparrow.gltf
*/

import React, { useRef } from 'react'
import { useGLTF, useAnimations } from '@react-three/drei'

export function Model(props) {
  const group = useRef()
  const { nodes, materials, animations } = useGLTF('/sparrow.gltf')
  const { actions } = useAnimations(animations, group)
  return (
    <group ref={group} {...props} dispose={null}>
      <group>
        <group name="Rig1" rotation={[-Math.PI / 2, 0, 0]} scale={40}>
          <primitive object={nodes.root2} />
        </group>
        <group name="Mesh12" rotation={[-Math.PI / 2, 0, 0]} scale={40}>
          <skinnedMesh name="mesh_0" geometry={nodes.mesh_0.geometry} material={nodes.mesh_0.material} skeleton={nodes.mesh_0.skeleton} />
        </group>
      </group>
    </group>
  )
}

useGLTF.preload('/sparrow.gltf')
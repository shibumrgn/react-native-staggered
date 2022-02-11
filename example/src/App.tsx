import React, { useEffect } from 'react'
import ReactNativeStaggeredModule, { Counter } from 'react-native-staggered'

const App = () => {
  useEffect(() => {
    console.log(ReactNativeStaggeredModule)
  })

  return <Counter />
}

export default App

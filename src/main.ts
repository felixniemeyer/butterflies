import { createApp } from 'vue'
import { createPinia } from 'pinia'
import aframe from 'aframe'

import App from './App.vue'
import router from './router'

import './body.less'

console.log(aframe.version)

const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount('#app')

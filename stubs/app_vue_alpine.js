import './bootstrap';
import Alpine from 'alpinejs'

window.Alpine = Alpine
Alpine.start()

import {createApp} from 'vue'

import App from './App.vue'

createApp(App).mount("#app")




import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  optimizeDeps: {
    exclude: ['send', 'etag', 'destroy', 'mime'] // 排除这些服务器端模块
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      fs: 'path-to-empty-module'
    },
  },
  server: {
    proxy: {
      '/api': {  // 所有 /api 开头的请求都会被代理
        target: 'http://127.0.0.1:9000',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '') // 将 /api 前缀删除
      }
    }
  }
})


//一定要注意上述的代理/api的路径只会在使用vite的开发服务器的时候起到baseUrl的作用，如果运行的是打包后的静态资源，则无法使用该配置文件的代理
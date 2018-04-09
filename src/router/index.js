import Vue from 'vue'
import Router from 'vue-router'
import store from '../store' 
import Login from '@/components/login/login'
import Index from '@/components/index/index'
import ActivityIndex from '@/components/activity/activityIndex.vue'

Vue.use(Router);

const router = new Router({
  mode:'history',
  routes: [
    {
      path: '/',
      component: Index
    },{
      path:'/activity',
      component:ActivityIndex,
      meta:{
        requireAuth: true
      }
    },{
      path: '/login',
      component: Login,
    },{
      path:'*',
      redirect: Index
    }
  ]
})


router.beforeEach((to, from, next) => {
  // 判断该路由是否需要登录权限
  if (to.meta.requireAuth) {
    // 判断vuex state中token是否存在
    if (store.state.token.token) {
      next();
    } else {
      next({
        path:'/login',
        query:{
          // 登录成功后跳转到该路由
          redirect:to.fullPath
        }
      })
    }
  }
  next();
})

export default router;

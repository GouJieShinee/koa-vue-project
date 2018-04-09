import Vue from 'vue'
import axios from 'axios'
import store from '../store'

Vue.prototype.$http = axios;

const config = require('../../config');

// 自定义axios的全局配置
process.env.NODE_ENV === 'production'
    ? axios.defaults.baseURL = config.build.assetsPublicPath
    : axios.defaults.baseURL = config.dev.assetsPublicPath;
axios.defaults.timeout = 2500; // 设置请求超时时间为2.5秒


// http request 拦截器
axios.interceptors.request.use(
    config => {
        if (store.state.token.token) { // 判断是否存在token，如果存在的话，则每个http header都加上token
            config.headers.Authorization = `${store.state.token.token}`;
        }
        return config;
    },
    err => {
        return Promise.reject(err);
    });

// http response 拦截器
axios.interceptors.response.use(
    response => {
        return response;
    },
    error => {
        if (error.response) {
            switch (error.response.status) {
                case 401:
                    // 返回 401 清除token信息并跳转到登录页面
                    store.commit('logout');
                    router.replace({
                        path: '/login',
                        query: {
                            redirect: router.currentRoute.fullPath
                        }
                    })
            }
        }
        return Promise.reject(error.response.data) // 返回接口返回的错误信息
    });

/**
 * axios get请求
 * @param {String} url 请求路径
 * @param {Object} params 请求参数（JSON格式）
 */
export function get(url,params={}){
    if(!url) {
        return new Promise((resolve, reject)=>{
            reject('请求路径为空！')
        })
    }

    return new Promise((resolve, reject)=>{
        axios.get(url, {
            params:params
        }).then(response=>{
            resolve(response.data)
        }).catch(error=>{
            reject(error)
        })
    })
}

/**
 * axios post请求
 * @param {String} url 请求路径
 * @param {Object} params 请求参数（JSON格式）
 */
export function post(url, params = {}) {
    
    if (!url) {
        return new Promise((resolve, reject) => {
            reject('请求路径为空！')
        })
    }

    // 健全post请求，请求路径上带了参数
    // 解析成json对象的请求参数
    let _params = params;

    if (url.indexOf('?') != -1) {
        let indexOf = url.indexOf('?');
        url = url.substring(0, indexOf);
        let _parm = url.substring(indexOf + 1);
        _parm = _parm.indexOf('?') != -1 ? _parm.split('&') : _parm;
        
        for(let i = 0, len=_parm.length; i < len; i++) {
            let curParm = _parm[i].split('=');
            _params[curParm[0]] = _params[curParm[1]];
        }
    }

    return new Promise((resolve, reject) => {
        axios.post(url, _params)
        .then(response => {
            resolve(response.data)
        }).catch(error => {
            reject(error)
        })
    })
}

/**
 * axios.all 多重并发请求
 * @param {Function} fun 多重并发请求函数
 */
export function all(...fun){
    if (!fun.length) {
        return new Promise((resolve, reject)=>{
            reject('请传入正确的请求函数')
        })
    }
    
    return new Promise((resolve, reject)=>{
        axios.all(fun)
        .then(axios.spread((...args)=>{
            resolve(args);
            
        })).catch(error=>{
            reject(error)
        })
    })
}
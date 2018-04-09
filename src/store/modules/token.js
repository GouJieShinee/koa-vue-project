const types = {
    GET_TOKEN:'getToken',
    LOGOUT:'logout'
}

let state = {
    token:''
}

let getters = {
    getToken: state=>{
        return state.token;
    }
}

let actions = {
    getToken: ({ commit })=>{
        commit(types.GET_TOKEN)
    },
    logout:({commit})=>{
        commit(types.LOGOUT)
    }
}

let mutations = {
    [types.GET_TOKEN]:state=>{
        state.token = '1234567890';
    },
    [types.LOGOUT]:state=>{
        state.token = null;
    }
}

export default {
    state,
    getters,
    actions,
    mutations
}
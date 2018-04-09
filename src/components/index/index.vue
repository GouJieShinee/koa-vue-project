<template>
  <div id="index">
    <router-link tag="a" to="/activity">点我跳转到活动页面</router-link>
      <hr />
    <button @click="getJson">点我从后端获取json数据，并带上token</button>
    <div>{{jsonData}}</div>
    <hr />
    <button @click="getJsonAll">点我多重并发请求</button>
    <div>{{dataAll}}</div>
    <hr />
    <button @click="getToken">点我设置token</button>
    <span>用户token：{{token}}</span>



  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

export default {
  data() {
    return {
      jsonData: [],
      dataAll: []
    };
  },
  created(){
    
    this.fetchData();
  },
  computed: {
    ...mapGetters({
      token: "getToken"
    })
  },
  methods: {
    fetchData(){
      this.$http.get('/zhaoshang_menus/menus',{
        params:{
          current_menu_id:1
        }
      }).then(data=>{
        console.log(data);
        
      })
    },
    getJson() {
      this.$get("/api/getGoodsLists")
        .then(response => {
          this.jsonData = response;
        })
        .catch(error => {
          console.log(error);
        });
    },
    getJsonAll() {
      var _self = this;
      function fun1() {
        return _self.$get("/api/getGoodsLists");
      }
      function fun2() {
        return _self.$get("/api/getGoodsOrder");
      }
      function fun3() {
        return _self.$get("/api/getGoodsOrder");
      }

      this.$all(fun1(), fun2(), fun3()).then(data => {
        this.dataAll = data;
      });
    },
    ...mapActions(["getToken"])
  }
};
</script>


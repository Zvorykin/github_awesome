<template>
  <b-container id="app" fluid>
    <b-col>
      <create-repo-form/>
      <repository-list/>
    </b-col>
  </b-container>
</template>

<script>

import CreateRepoForm from './components/create_repo_form'
import RepositoryList from './components/repository_list'

export default {
  components: {
    CreateRepoForm,
    RepositoryList
  }
}
</script>

<style scoped>
  #app {
    margin-top: 15px;
  }
</style>

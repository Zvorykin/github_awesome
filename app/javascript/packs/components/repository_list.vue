<template>
  <b-row>
    <b-card-group deck>
      <b-card style="min-width: 500px">
        <template #header>
          <b-button type="button" variant="success" @click="refresh">Refresh</b-button>
        </template>
        <b-tree-view :data="treeData" :renameNodeOnDblClick='false'
                     @nodeSelect="nodeSelect" nodeKeyProp="node_id"></b-tree-view>
      </b-card>
      <b-card :header="selectedRepository.category_name" :title="selectedRepository.name"
              v-show="selectedRepository.node_id">
        <b-card-text> {{ selectedRepository.short_description }}</b-card-text>
        <b-card-text> Owner: {{ selectedRepository.owner }}</b-card-text>
        <b-card-text> Pushed at: {{ selectedRepository.pushed_at }}</b-card-text>
        <b-card-text> Stars: {{ selectedRepository.stars_count }}</b-card-text>
        <b-card-text> Forks: {{ selectedRepository.fork_count }}</b-card-text>
        <b-card-text> Main language: {{ selectedRepository.language }}</b-card-text>
      </b-card>
    </b-card-group>
  </b-row>
</template>

<script>
import { bTreeView } from 'bootstrap-vue-treeview'

export default {
  name: "repository_list",
  components: {
    bTreeView
  },
  data() {
    return {
      treeData: [],
      selectedRepository: {
        node_id: null,
        name: '',
        owner: '',
        pushed_at: '',
        stars_count: 0,
        forks_count: 0,
        short_description: '',
        category_name: ''
      }
    }
  },
  methods: {
    async refresh() {
      this.treeData = await this.getTechnologies()
    },

    async getTechnologies() {
      const response = await this.axios.get(
          '/technologies',
          {
            params: {
              tree_view: true
            }
          }
      )
      return response.data.objects
    },

    nodeSelect(node, isSelected) {
      if (!isSelected) return
      if (!node.data.node_id.startsWith('repository')) return

      this.selectedRepository = node.data
    }
  },
  async created() {
    await this.refresh()
  }
}
</script>

<style scoped>
</style>
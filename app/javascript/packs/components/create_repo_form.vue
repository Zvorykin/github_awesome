<template>
  <b-row style="margin-bottom: 15px">
    <b-form @submit="onSubmit" inline>
      <b-input id="form-input-technology" class="mb-2 mr-sm-2 mb-sm-0" placeholder="technology"
               v-model="form.technology"></b-input>
      <b-input id="form-input-category" class="mb-2 mr-sm-2 mb-sm-0" placeholder="category"
               v-model="form.category"></b-input>
      <b-input id="form-input-repository" class="mb-2 mr-sm-2 mb-sm-0" placeholder="repository"
               v-model="form.repository"></b-input>
      <b-button type="submit" variant="primary">Add repository</b-button>
    </b-form>
  </b-row>
</template>

<script>
export default {
  name: "create_repo_form",
  data() {
    return {
      form: {
        technology: '',
        category: '',
        repository: ''
      }
    }
  },
  methods: {
    async onSubmit(event) {
      event.preventDefault()

      await this.axios.post('/repositories', { repository: this.form })

      this.$bvToast.toast(
          'New repository will be added soon. Please refresh list in a minute or two.',
          { variant: 'success' }
      )
    }
  }
}
</script>

<style scoped>
</style>
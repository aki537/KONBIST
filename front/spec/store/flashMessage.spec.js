// import Vuex from 'vuex'
// import { createLocalVue } from '@vue/test-utils'

// const localVue = createLocalVue();
// localVue.use(Vuex);

const Vuex = require('vuex')
const messages = require('../../store/flashMessage')
const { createLocalVue } = require('@vue/test-utils')
const cloneDeep = require('lodash.clonedeep')

const localVue = createLocalVue()
localVue.use(Vuex)

describe('フラッシュメッセージ', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(messages))
  })

  describe('actions', () => {
    test('フラッシュメッセージが表示されるか', async () => {
      const payload = { message: "testmessage", type: "info", status: "true" }
      await store.dispatch('showMessage', payload)
      expect(store.getters['message']).toEqual(payload.message)
    })
  })
})
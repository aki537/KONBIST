/* eslint-disable */

const Vuex = require('vuex')
const foods = require('../../store/choise')
const { createLocalVue } = require('@vue/test-utils')
const cloneDeep = require('lodash.clonedeep')

const localVue = createLocalVue()
localVue.use(Vuex)

describe('フード選択', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(foods))
  })

  describe('actions', () => {
    test('フードを選択', async () => {
      const payload = { name: "test", calorie: 100, carbonhydrate: 50, protein: 10.2, lipid: 6.9 }
      await store.dispatch('addFood', payload)
      expect(store.getters['food']).toEqual(payload)
    })
    test('フードを削除', async () => {
      const payload = { name: "test", calorie: 100, carbonhydrate: 50, protein: 10.2, lipid: 6.9 }
      await store.dispatch('deleteFood', payload)
      expect(store.getters['foods']).toEqual([])
    })
  })
})

/* eslint-enable */

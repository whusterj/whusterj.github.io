---
layout: post
title: "Elastic TextArea Component with VueJS"
date: 2018-01-27 22:00
description: 
category: blog
tags: python programming
---

<template>
  <textarea
    :name="name"
    :class="{
      'full-width': fullWidth
    }"
    ref="theTextArea"
    v-on:input.prevent="resizeTextArea"
    v-on:change.prevent="resizeTextArea"
    :value="value"
    @input="updateText()"
  ></textarea>
</template>

<script>
export default {
  name: 'ElasticTextarea',
  props: {
    value: {
      type: String,
      required: true,
      default: '',
    },
    name: {
      type: String,
      required: true,
    },
    fullWidth: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  data() {
    return {
      initialHeight: null,
    };
  },
  mounted() {
    this.initialHeight = (
      this.initialHeight || this.$el.style.height
    );
    this.resizeTextArea();
  },
  methods: {
    resizeTextArea() {
      this.$el.style.height = this.initialHeight;
      this.$el.style.height = `${this.$el.scrollHeight}px`;
    },
    updateText() {
      this.$emit('input', this.$el.value);
    },
  },
};
</script>

<style scoped>
textarea {
  resize: none;
  overflow: hidden;
}
.full-width {
  width: 100%;
}
</style>
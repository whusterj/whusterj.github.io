---
layout: post
title: "Live Form Validation with VueJS"
date: 2018-01-21 09:00
description: Use JavaScript to validate user input in real time without a framework.
category: blog
tags: javascript programming vuejs
---

<div id="app">
  <form
    v-on:submit.prevent="handleSubmit"
    v-on:input="handleInput"
    v-on:focusout="handleFocusOut($event)"
  >
    <div>
      <input
        type="text" name="firstName" placeholder="First name"
        v-model="profile.firstName.value"
      >
      <span
        class="field-error"
        v-if="profile.firstName.touched && fieldError('firstName')"
        v-text="fieldError('firstName')"
      ></span>
      <span
        class="field-success"
        v-if="profile.firstName.touched && !fieldError('firstName')"
      >
        ✓
      </span>
    </div>
    <div>
      <input
        type="text" name="lastName" placeholder="Last name"
        v-model="profile.lastName.value"
      >
      <span
        class="field-error"
        v-if="profile.lastName.touched && fieldError('lastName')"
        v-text="fieldError('lastName')"
      ></span>
      <span
        class="field-error"
        v-if="profile.lastName.touched && !fieldError('lastName')"
      >
        ✓
      </span>
    </div>
    <div>
      <textarea
        type="text" name="bio" placeholder="Bio"
        v-model="profile.bio.value"
      ></textarea>
      <span
        class="field-error"
        v-if="profile.bio.touched && fieldError('bio')"
        v-text="fieldError('bio')"
      ></span>
      <span
        class="field-error"
        v-if="profile.bio.touched && !fieldError('bio')"
      >
        ✓
      </span>
    </div>
    <button type="submit">Save</button>
  </form>
</div>

<script src="{{ '/static/js/vue.2.5.13.min.js' | absolute_url }}"></script>

<script>
const state = {
  profile: {
    firstName: {
      value: '',
      touched: false,
    },
    lastName: {
      value: '',
      touched: false,
    },
    bio: {
      value: '',
      touched: false,
    }
  },
  errors: [],
};

new Vue({
  el: '#app',
  data() {
    return {
      profile: state.profile,
      errors: state.errors,
    };
  },
  methods: {
    fieldError(fieldName) {
      const error = this.errors.filter(e => e.field === fieldName);
      return error.length ? error[0].message : null;
    },
    validate() {
      this.errors = validateProfile(this.profile);
    },
    handleSubmit() {
      // Mark all fields touched
      this.profile.firstName.touched = true;
      this.profile.lastName.touched = true;
      this.profile.bio.touched = true;

      this.validate();

      // No errors. Save the data.
      if (this.errors.length === 0) {
        // In a real application, this is where we
        // would make an Ajax call or call or
        // form.submit() to save the form data.
        alert('The form looks good. We can save the data!');
      }
    },
    handleInput() {
      this.errors = validateProfile(this.profile);
    },
    handleFocusOut(event) {
      const fieldName = event.target.name;
      if (this.profile[fieldName]) {
        this.profile[fieldName].touched = true;
      }
      this.validate();
    },
  }
});

/*
 * Validate the current profile values.
 */
function validateProfile(profile) {
  const errors = [];

  // Validate the 'first name' field
  if (!profile.firstName.value) {
    errors.push({
      field: 'firstName',
      message: 'Please enter your first name.',
    });
  }

  // Validate the 'last name' field
  if (!profile.lastName.value) {
    errors.push({
      field: 'lastName',
      message: 'Please enter your last name.',
    });
  }

  // Validate the 'bio' field
  const requiredWordCount = 8;
  const bioWordCount = profile.bio.value.split(' ')
                                        .filter(i => i !== '')
                                        .length;
  if (!profile.bio.value || bioWordCount < requiredWordCount) {
    const wordCountDiff = requiredWordCount - bioWordCount;
    errors.push({
      field: 'bio',
      message: (
        `Please write at least ${wordCountDiff} more word` +
        (wordCountDiff > 1 ? 's': '') + '.'
      ),
    });
  }

  return errors;
}
</script>

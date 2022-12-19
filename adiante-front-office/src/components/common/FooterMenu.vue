<template>
 <div class="navbar navbar-footer fixed-bottom">

    <ul class="nav">
        <li>
          <a href="#" class="nav-link active">
            <span class="material-symbols-outlined">
              home
              </span>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <span class="material-symbols-outlined">
              calendar_month
              </span>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <span class="material-symbols-outlined">
              apps
              </span>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <span class="material-symbols-outlined">
              chat
              </span>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <span class="material-symbols-outlined">
              mail
              </span>
          </a>
        </li>
      </ul>
    </div>
</template> 

      <script>
export default {
  name: 'FooterMemu',
  props: {
    msg: String
  }
}
</script>
 
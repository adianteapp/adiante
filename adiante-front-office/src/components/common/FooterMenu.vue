<template>
 <div class="navbar navbar-footer fixed-bottom">

    <ul class="nav">
        <li>
          <a href="#" class="nav-link ">
            <div class="active"></div>
            <div class="icon icon-home"> </div>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <div class="icon icon-calendar"> </div>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <div class="icon icon-retos">  </div>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <div class="icon icon-chat"> </div>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link">
            <div class="icon icon-contact"> </div>
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
 
<template>
  <div class="navbar-footer fixed-bottom">

    <ul class="nav">
        <li>
          <a href="/dashboard" class="nav-link  "> 
            <i class="icon-menu-home"> </i>
          </a>
        </li>
        <li>
          <a href="/agenda" class="nav-link active">
            <i class="icon-menu-retos"> </i>
          </a>
        </li>
        <li>
          <a href="#" class="nav-link ">
            <i class="icon-menu-calendar"> </i>
          </a>
        </li>
        
        <li>
          <a href="#" class="nav-link  ">
            <i class="icon-menu-contact"> </i>
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
 
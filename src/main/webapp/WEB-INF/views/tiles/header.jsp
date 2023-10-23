<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   
<nav id="hadbar" class="topnav navbar navbar-light"  style="display:none;">
   <button type="button" id="inModal" class="navbar-toggler text-muted mt-2 p-0 mr-3 collapseSidebar" >
      <i class="fe fe-menu navbar-toggler-icon"></i>
   </button>
   <ul class="nav">
      <li class="nav-item">
      	<a class="nav-link text-muted my-2" href="#" id="modeSwitcher" data-mode="light">
      	 <i class="fe fe-sun fe-16"></i>
      	</a></li>
      	
      <li class="nav-item">
      	<a class="nav-link text-muted my-2" href="./#" data-toggle="modal" data-target=".modal-shortcut">
       	 <span class="fe fe-grid fe-16"></span>
      	</a></li>
      	
      <li class="nav-item nav-notif">
    	<a class="nav-link text-muted my-2" href="./#" data-toggle="modal" data-target=".modal-notif">
    		<span class="fe fe-bell fe-16"></span>
            <span class="dot dot-md bg-success"></span>
        </a></li>
        
      <li class="nav-item dropdown">
	     <a  class="nav-link dropdown-toggle text-muted pr-0" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
	      <span class="avatar avatar-sm mt-2">
	      	<img src="/resources/light/assets/avatars/face-1.jpg" alt="..." class="avatar-img rounded-circle"> 
	      </span>
	     </a>
         <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
            <a class="dropdown-item" href="#">Profile</a>
            <a class="dropdown-item" href="#">Settings</a>
            <a class="dropdown-item" href="#">Activities</a>
         </div></li>
   </ul>
</nav>

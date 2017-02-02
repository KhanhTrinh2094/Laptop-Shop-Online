<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
  Response.Redirect("index.asp")
%>
<!DOCTYPE html>
<html lang="en"><!-- InstanceBegin template="/Templates/Template.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

    <title>Admin Panel</title>
<!-- InstanceEndEditable -->
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->

    <link rel="icon" type="image/ico" href="favicon.ico"/>
    
    <link href="css/stylesheets.css" rel="stylesheet" type="text/css" />
    <link rel='stylesheet' type='text/css' href='css/fullcalendar.print.css' media='print' />
    
    <script type='text/javascript' src='js/plugins/jquery/jquery-1.10.2.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery-ui-1.10.1.custom.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery-migrate-1.2.1.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery.mousewheel.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/cookie/jquery.cookies.2.2.0.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/bootstrap.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/charts/jquery.flot.js'></script>    
    <script type='text/javascript' src='js/plugins/charts/jquery.flot.stack.js'></script>    
    <script type='text/javascript' src='js/plugins/charts/jquery.flot.pie.js'></script>
    <script type='text/javascript' src='js/plugins/charts/jquery.flot.resize.js'></script>
    
    <script type='text/javascript' src='js/plugins/sparklines/jquery.sparkline.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/fullcalendar/fullcalendar.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/select2/select2.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/uniform/uniform.js'></script>
    
    <script type='text/javascript' src='js/plugins/maskedinput/jquery.maskedinput-1.3.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/validation/languages/jquery.validationEngine-en.js' charset='utf-8'></script>
    <script type='text/javascript' src='js/plugins/validation/jquery.validationEngine.js' charset='utf-8'></script>
    
    <script type='text/javascript' src='js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js'></script>
    <script type='text/javascript' src='js/plugins/animatedprogressbar/animated_progressbar.js'></script>
    
    <script type='text/javascript' src='js/plugins/qtip/jquery.qtip-1.0.0-rc3.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/cleditor/jquery.cleditor.js'></script>
    
    <script type='text/javascript' src='js/plugins/dataTables/jquery.dataTables.min.js'></script>    
    
    <script type='text/javascript' src='js/plugins/fancybox/jquery.fancybox.pack.js'></script>
    
    <script type='text/javascript' src='js/plugins/pnotify/jquery.pnotify.min.js'></script>
    <script type='text/javascript' src='js/plugins/ibutton/jquery.ibutton.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/scrollup/jquery.scrollUp.min.js'></script>
    <script type='text/javascript' src='js/cookies.js'></script>
    <script type='text/javascript' src='js/actions.js'></script>
    <script type='text/javascript' src='js/charts.js'></script>
    <script type='text/javascript' src='js/plugins.js'></script>
    <script type='text/javascript' src='js/settings.js'></script>

    
</head>
<body>
    <div class="header">
        <a class="logo" href="index.asp"><img src="img/logo.png" alt="Admin Panel" title="Admin Panel" style="height: 30px; width: 120px" /></a>
        <ul class="header_menu">
            <li class="list_icon"><a href="#">&nbsp;</a></li>
        </ul>    
    </div>
    
    <div class="menu">                
        
        <div class="breadLine">            
            <div class="arrow"></div>
            <div class="adminControl active">
                Hi, Admin
          </div>
        </div>
        
        <div class="admin">
            <div class="image">
                <img src="img/users/admin.png" class="img-polaroid"/>                
            </div>
            <ul class="control">                
                <li><span class="icon-comment"></span> <a href="admin.asp">Admin</a></li>
                <li><span class="icon-cog"></span> <a href="doimatkhau.asp">Đổi mật khẩu</a></li>
                <li><span class="icon-share-alt"></span> <a href="dangxuat.asp">Đăng xuất</a></li>
            </ul>
            <div class="info">
                <span>Chào mừng bạn quay trở lại !!!</span>
            </div>
        </div>
        
        <ul class="navigation">            
            <li class="active">
                <a href="index.asp">
                    <span class="isw-grid"></span><span class="text">Trang chủ</span>
                </a>
            </li>
            <li>
                <a href="quanlysanpham.asp">
                    <span class="isw-list"></span><span class="text">Quản lý sản phẩm</span>
                </a>               
            </li>          
            <li>
                <a href="quanlydonhang.asp">
                    <span class="isw-archive"></span><span class="text">Quản lý đơn hàng</span>                 
                </a>
            </li>                        
            <li>
                <a href="quanlythanhvien.asp">
                    <span class="isw-user"></span><span class="text">Quản lý thành viên</span>
                </a>   
            </li>
            <li class="openable">
                <a href="#">
                    <span class="isw-chat"></span><span class="text">Quản lý phản hồi</span>                    
                </a>
                <ul>
                    <li>
                        <a href="quanlyphanhoi.asp">
                            <span class="icon-picture"></span><span class="text">Quản lý góp ý</span>
                        </a>
                    </li>
                    <li>
                        <a href="quanlybinhluan.asp">
                            <span class="icon-pencil"></span><span class="text">Quản lý bình luận</span>
                        </a>
                    </li>                   
                </ul>
            </li> 
            <li>
                <a href="quanlytintuc.asp">
                    <span class="isw-text_document"></span><span class="text">Quản lý tin tức</span>
                </a>   
            </li>
            <li>
                <a href="quanlyhangsanxuat.asp">
                    <span class="isw-plus"></span><span class="text">Quản lý hãng sản xuất</span>
                </a>
            </li> 			
            <li>
                <a href="thongke.asp">
                    <span class="isw-graph"></span><span class="text">Thống kê</span>
                </a>
            </li>                                                                                                                    
        </ul>
        
        <div class="dr"><span></span></div>
        
        <div class="widget-fluid">
            <div id="menuDatepicker"></div>
        </div>
        
        <div class="dr"><span></span></div>   
    </div>
        
    <div class="content">
        
        
<div class="breadLine">
                        
            <ul class="buttons">               
                <li>
                    <a href="dangxuat.asp"><span class="icon-search"></span><span class="text">Thoát</span></a>                
                </li>
            </ul>
            
        </div>
        <div class="workplace">
<!-- InstanceBeginEditable name="EditRegion3" -->
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<!-- InstanceEndEditable -->
</div>
</div>
</body>
<!-- InstanceEnd --></html>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="dangnhap.asp"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
%>
<!--#include file="../Connections/cn.asp" -->
<%
Dim rsSanPham
Dim rsSanPham_cmd
Dim rsSanPham_numRows

Set rsSanPham_cmd = Server.CreateObject ("ADODB.Command")
rsSanPham_cmd.ActiveConnection = MM_cn_STRING
rsSanPham_cmd.CommandText = "SELECT COUNT(*) AS sanpham FROM dbo.tbSanPham" 
rsSanPham_cmd.Prepared = true

Set rsSanPham = rsSanPham_cmd.Execute
rsSanPham_numRows = 0
%>
<%
Dim rsSanphamHH
Dim rsSanphamHH_cmd
Dim rsSanphamHH_numRows

Set rsSanphamHH_cmd = Server.CreateObject ("ADODB.Command")
rsSanphamHH_cmd.ActiveConnection = MM_cn_STRING
rsSanphamHH_cmd.CommandText = "SELECT COUNT(*) as sanphamHH FROM dbo.tbSanPham WHERE TrangThai = 0" 
rsSanphamHH_cmd.Prepared = true

Set rsSanphamHH = rsSanphamHH_cmd.Execute
rsSanphamHH_numRows = 0
%>
<%
Dim rsDonhang
Dim rsDonhang_cmd
Dim rsDonhang_numRows

Set rsDonhang_cmd = Server.CreateObject ("ADODB.Command")
rsDonhang_cmd.ActiveConnection = MM_cn_STRING
rsDonhang_cmd.CommandText = "SELECT Count(*) as hoadon FROM dbo.tbHoaDon" 
rsDonhang_cmd.Prepared = true

Set rsDonhang = rsDonhang_cmd.Execute
rsDonhang_numRows = 0
%>
<%
Dim rsDonhangHH
Dim rsDonhangHH_cmd
Dim rsDonhangHH_numRows

Set rsDonhangHH_cmd = Server.CreateObject ("ADODB.Command")
rsDonhangHH_cmd.ActiveConnection = MM_cn_STRING
rsDonhangHH_cmd.CommandText = "SELECT count(*) as hoadonHH FROM dbo.tbHoaDon WHERE TrangThai = 0" 
rsDonhangHH_cmd.Prepared = true

Set rsDonhangHH = rsDonhangHH_cmd.Execute
rsDonhangHH_numRows = 0
%>
<%
Dim rsThanhvien
Dim rsThanhvien_cmd
Dim rsThanhvien_numRows

Set rsThanhvien_cmd = Server.CreateObject ("ADODB.Command")
rsThanhvien_cmd.ActiveConnection = MM_cn_STRING
rsThanhvien_cmd.CommandText = "SELECT Count(*) as thanhvien FROM dbo.tbKhachHang" 
rsThanhvien_cmd.Prepared = true

Set rsThanhvien = rsThanhvien_cmd.Execute
rsThanhvien_numRows = 0
%>
<%
Dim rsThanhvienHH
Dim rsThanhvienHH_cmd
Dim rsThanhvienHH_numRows

Set rsThanhvienHH_cmd = Server.CreateObject ("ADODB.Command")
rsThanhvienHH_cmd.ActiveConnection = MM_cn_STRING
rsThanhvienHH_cmd.CommandText = "SELECT Count(*) as thanhvienhh FROM dbo.tbKhachHang WHERE TrangThai = 0" 
rsThanhvienHH_cmd.Prepared = true
rsThanhvienHH_cmd.Parameters.Append rsThanhvienHH_cmd.CreateParameter("param1", 200, 1, 20, rsThanhvienHH__MMColParam) ' adVarChar

Set rsThanhvienHH = rsThanhvienHH_cmd.Execute
rsThanhvienHH_numRows = 0
%>
<%
Dim rsGopy
Dim rsGopy_cmd
Dim rsGopy_numRows

Set rsGopy_cmd = Server.CreateObject ("ADODB.Command")
rsGopy_cmd.ActiveConnection = MM_cn_STRING
rsGopy_cmd.CommandText = "SELECT count(*) as phanhoi FROM dbo.tbPhanHoi" 
rsGopy_cmd.Prepared = true

Set rsGopy = rsGopy_cmd.Execute
rsGopy_numRows = 0
%>
<%
Dim rsBinhluan
Dim rsBinhluan_cmd
Dim rsBinhluan_numRows

Set rsBinhluan_cmd = Server.CreateObject ("ADODB.Command")
rsBinhluan_cmd.ActiveConnection = MM_cn_STRING
rsBinhluan_cmd.CommandText = "SELECT count(*) as binhluan FROM dbo.tbBinhLuan" 
rsBinhluan_cmd.Prepared = true

Set rsBinhluan = rsBinhluan_cmd.Execute
rsBinhluan_numRows = 0
%>
<%
Dim rsTintuc
Dim rsTintuc_cmd
Dim rsTintuc_numRows

Set rsTintuc_cmd = Server.CreateObject ("ADODB.Command")
rsTintuc_cmd.ActiveConnection = MM_cn_STRING
rsTintuc_cmd.CommandText = "SELECT Count(*) as tintuc FROM dbo.tbTinTuc" 
rsTintuc_cmd.Prepared = true

Set rsTintuc = rsTintuc_cmd.Execute
rsTintuc_numRows = 0
%>
<%
Dim rsHSX
Dim rsHSX_cmd
Dim rsHSX_numRows

Set rsHSX_cmd = Server.CreateObject ("ADODB.Command")
rsHSX_cmd.ActiveConnection = MM_cn_STRING
rsHSX_cmd.CommandText = "SELECT COUNT(*) as HSX FROM dbo.tbHangSanXuat" 
rsHSX_cmd.Prepared = true

Set rsHSX = rsHSX_cmd.Execute
rsHSX_numRows = 0
%>
<!DOCTYPE html>
<html lang="en"><!-- InstanceBegin template="/Templates/Template.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

    <title>Thống kê</title>
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
                <div class="page-header">
                   <h1>Thống kê Website</h1>
                </div>  
                
                <div class="row-fluid">

                    <div class="span12">
                        <div class="head clearfix">
                            <div class="isw-documents"></div>
                            <h1>Thống kê Website</h1>
                        </div>
                        <div class="block-fluid">                        
                            <div class="row-form clearfix">
                                <div class="span3">Sản phẩm : </div>
                                <div class="span9">Hiện có <%=(rsSanPham.Fields.Item("sanpham").Value)%> sản phẩm đang được rao bán. Trong đó <%=(rsSanphamHH.Fields.Item("sanphamHH").Value)%> sản phẩm đã hết hàng.</div>
                            </div>
                       </div>
                       <div class="block-fluid">                        
                            <div class="row-form clearfix">
                                <div class="span3">Đơn hàng : </div>
                                <div class="span9">Hiện có <%=(rsDonhang.Fields.Item("hoadon").Value)%> đơn hàng. Trong đó <%=(rsDonhangHH.Fields.Item("hoadonHH").Value)%> đơn hàng đang chờ xử lý.</div>
                            </div>
                       </div>
                       <div class="block-fluid">                        
                            <div class="row-form clearfix">
                                <div class="span3">Thành viên : </div>
                                <div class="span9">Hiện có <%=(rsThanhvien.Fields.Item("thanhvien").Value)%> thành viên. Trong đó <%=(rsThanhvienHH.Fields.Item("thanhvienHH").Value)%> thành viên đang tạm khóa.</div>
                            </div>
                       </div>
                       <div class="block-fluid">                        
                            <div class="row-form clearfix">
                                <div class="span3">Phải hồi : </div>
                                <div class="span9">Hiện có <%=(rsGopy.Fields.Item("phanhoi").Value)%> góp ý và <%=(rsBinhluan.Fields.Item("binhluan").Value)%> bình luận.</div>
                            </div>
                       </div>
                       <div class="block-fluid">                        
                            <div class="row-form clearfix">
                                <div class="span3">Tin tức : </div>
                                <div class="span9">Hiện có <%=(rsTintuc.Fields.Item("tintuc").Value)%> tin tức được đăng tải.</div>
                            </div>
                       </div>
                       <div class="block-fluid">                        
                            <div class="row-form clearfix">
                                <div class="span3">Hãng sản xuất : </div>
                                <div class="span9">Hiện có <%=(rsHSX.Fields.Item("HSX").Value)%> hãng sản xuất.</div>
                            </div>
                       </div>
                  </div>
               </div>
<!-- InstanceEndEditable -->
</div>
</div>
</body>
<!-- InstanceEnd --></html>
<%
rsSanPham.Close()
Set rsSanPham = Nothing
%>
<%
rsSanphamHH.Close()
Set rsSanphamHH = Nothing
%>
<%
rsDonhang.Close()
Set rsDonhang = Nothing
%>
<%
rsDonhangHH.Close()
Set rsDonhangHH = Nothing
%>
<%
rsThanhvien.Close()
Set rsThanhvien = Nothing
%>
<%
rsGopy.Close()
Set rsGopy = Nothing
%>
<%
rsBinhluan.Close()
Set rsBinhluan = Nothing
%>
<%
rsTintuc.Close()
Set rsTintuc = Nothing
%>
<%
rsHSX.Close()
Set rsHSX = Nothing
%>
<%
rsThanhvienHH.Close()
Set rsThanhvienHH = Nothing
%>

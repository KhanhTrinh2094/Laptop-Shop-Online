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
Dim rsHoadon
Dim rsHoadon_cmd
Dim rsHoadon_numRows

Set rsHoadon_cmd = Server.CreateObject ("ADODB.Command")
rsHoadon_cmd.ActiveConnection = MM_cn_STRING
rsHoadon_cmd.CommandText = "SELECT * FROM dbo.tbHoaDon WHERE ID = ?" 
rsHoadon_cmd.Prepared = true
rsHoadon_cmd.Parameters.Append rsHoadon_cmd.CreateParameter("param1", 5, 1, -1, request.QueryString("ID")) ' adDouble

Set rsHoadon = rsHoadon_cmd.Execute
rsHoadon_numRows = 0
%>
<%
Dim rsDathang
Dim rsDathang_cmd
Dim rsDathang_numRows

Set rsDathang_cmd = Server.CreateObject ("ADODB.Command")
rsDathang_cmd.ActiveConnection = MM_cn_STRING
rsDathang_cmd.CommandText = "SELECT * FROM dbo.tbDatHang WHERE HDID = ?" 
rsDathang_cmd.Prepared = true
rsDathang_cmd.Parameters.Append rsDathang_cmd.CreateParameter("param1", 5, 1, -1, (rsHoadon.Fields.Item("ID").Value)) ' adDouble

Set rsDathang = rsDathang_cmd.Execute
rsDathang_numRows = 0
%>
<%
Dim rsKhachhang__MMColParam
rsKhachhang__MMColParam = "1"
If (Request.QueryString("ID") <> "") Then 
  rsKhachhang__MMColParam = Request.QueryString("ID")
End If
%>
<%
Dim rsKhachhang
Dim rsKhachhang_cmd
Dim rsKhachhang_numRows

Set rsKhachhang_cmd = Server.CreateObject ("ADODB.Command")
rsKhachhang_cmd.ActiveConnection = MM_cn_STRING
rsKhachhang_cmd.CommandText = "SELECT ID, TenDangNhap, HoTen FROM dbo.tbKhachHang WHERE ID = ?" 
rsKhachhang_cmd.Prepared = true
rsKhachhang_cmd.Parameters.Append rsKhachhang_cmd.CreateParameter("param1", 5, 1, -1, (rsHoadon.Fields.Item("KHID").Value)) ' adDouble

Set rsKhachhang = rsKhachhang_cmd.Execute
rsKhachhang_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsDathang_numRows = rsDathang_numRows + Repeat1__numRows
%>

<!DOCTYPE html>
<html lang="en"><!-- InstanceBegin template="/Templates/Template.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

    <title>Thông tin đơn hàng</title>
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
                   <h1>Thông tin đơn hàng</h1>
                </div>  
                
                <div class="row-fluid">

                    <div class="span12">
                        <div class="head clearfix">
                            <div class="isw-documents"></div>
                            <h1>Thông tin đơn hàng</h1>
                        </div>
                        <div class="block-fluid">                        
                            <div class="row-form clearfix">
                                <div class="span3">Người đặt hàng:</div>
                                <div class="span9"><a href="thongtinthanhvien.asp?id=<%=(rsKhachhang.Fields.Item("ID").Value)%>"><%=(rsKhachhang.Fields.Item("Hoten").Value)%></a></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Người nhận hàng:</div>
                                <div class="span9"><%=(rsHoadon.Fields.Item("TenNguoiNhan").Value)%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Thời gian giao hàng:</div>
                                <div class="span9"><%=(rsHoadon.Fields.Item("ThoiGian").Value)%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Địa chỉ:</div>
                                <div class="span9"><%=(rsHoadon.Fields.Item("DiaChi").Value)%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Email:</div>
                                <div class="span9"><%=(rsHoadon.Fields.Item("Email").Value)%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Số điện thoại:</div>
                                <div class="span9"><%=(rsHoadon.Fields.Item("DienThoai").Value)%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Giới tính:</div>
                                <div class="span9"><% if(rsHoadon.Fields.Item("GioiTinh").Value) = True Then
	  response.write("Nam")
	  Else
response.write("Nữ")
End If
%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Ghi chú:</div>
                                <div class="span9"><%=(rsHoadon.Fields.Item("GhiChu").Value)%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span9">Sản phẩm đã đặt:</div>
                            </div>          
<%
Dim rsSanpham
Dim rsSanpham_cmd
Dim rsSanpham_numRows
Dim Tien
Dim Tongtien
T0ngtien = 0
Dim Gia4 (10)
Function Gia(Giathanh)
		Gia1 = CSTR(Giathanh)
		Gia2 = len(Gia1)
		Gia4(0) = Mid(Gia1, 5, 3)
		Gia4(2) = Mid(Gia1, 1, Gia2-6)
		Gia4(1) = Mid(Gia1, 2, 3)
		Response.Write(Gia4(2) & "." & Gia4(1) & "." & Gia4(0))
End Function
%>
<% While ((Repeat1__numRows <> 0) AND (NOT rsDathang.EOF)) %>
<%
Set rsSanpham_cmd = Server.CreateObject ("ADODB.Command")
rsSanpham_cmd.ActiveConnection = MM_cn_STRING
rsSanpham_cmd.CommandText = "SELECT * FROM dbo.tbSanPham WHERE ID = ?" 
rsSanpham_cmd.Prepared = true
rsSanpham_cmd.Parameters.Append rsSanpham_cmd.CreateParameter("param1", 5, 1, -1, rsDathang.Fields.Item("SPID").Value) ' adDouble

Set rsSanpham = rsSanpham_cmd.Execute
rsSanpham_numRows = 0
Tien = (rsDathang.Fields.Item("SoLuong").Value) * (rsSanpham.Fields.Item("GiaSanPham").Value)
Tongtien = Tongtien + Tien
%>
<div class="row-form clearfix">
<div class="span9">
								<div class="span3">
								
                                </div>
                                <div class="span3">
									Tên : <%=(rsSanpham.Fields.Item("TenSanPham").Value)%>
                                </div>
                                <div class="span3">
									Số lượng : <%=(rsDathang.Fields.Item("SoLuong").Value)%>
                                </div>
                                <div class="span3">
									Tổng tiền : <%=Gia(Tien)%> VND
                                </div>
</div>
</div>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsDathang.MoveNext()
Wend
%>
                            <div class="row-form clearfix">
                                <div class="span3">Tổng giá trị:</div>
                                <div class="span9"><%=Gia(Tongtien)%> VND</div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Trạng thái:</div>
                                <div class="span9"><% if(rsHoadon.Fields.Item("TrangThai").Value) = 1 Then
	  response.write("Đã xử lý")
	  Else
response.write("Chưa xử lý")
End If
%></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Thao tác:</div>
                                <div class="span9"><% if(rsHoadon.Fields.Item("TrangThai").Value) = 1 Then %>
	  <a href="suadonhang.asp?id=<%=(rsHoadon.Fields.Item("ID").Value)%>&action=lock"><button class="btn" type="button">Chưa xử lý</button></a>
<%	  Else %>
<a href="suadonhang.asp?id=<%=(rsHoadon.Fields.Item("ID").Value)%>&action=unlock"><button class="btn" type="button">Xử lý</button></a>
<% End If %>
 <a href="xoadonhang.asp?id=<%=(rsHoadon.Fields.Item("ID").Value)%>"><button class="btn btn-danger" type="button">Xóa</button></a>
                                </div>
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
rsDathang.Close()
Set rsDathang = Nothing
%>
<%
rsKhachhang.Close()
Set rsKhachhang = Nothing
%>

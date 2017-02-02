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
Dim rsKhachhang
Dim rsKhachhang_cmd
Dim rsKhachhang_numRows

Set rsKhachhang_cmd = Server.CreateObject ("ADODB.Command")
rsKhachhang_cmd.ActiveConnection = MM_cn_STRING
rsKhachhang_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang" 
rsKhachhang_cmd.Prepared = true

Set rsKhachhang = rsKhachhang_cmd.Execute
rsKhachhang_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsKhachhang_numRows = rsKhachhang_numRows + Repeat1__numRows
%>
<!DOCTYPE html>
<html lang="en"><!-- InstanceBegin template="/Templates/Template.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

    <title>Quản lý thành viên</title>
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
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				$('#example').dataTable( {
					"aaSorting": [[ 4, "desc" ]]
				} );
			} );
		</script>
                <div class="page-header">
                   <h1>Quản lý thành viên</h1>
                </div>
                <% if((Request.QueryString("update")) = "ok") then %>
                <div class="alert alert-success">                
                    <h4>Thành công!</h4>
                    Khóa thành viên thành công. Thành viên này sẽ không thể hoạt động cho đến khi kích hoạt lại.
                </div> 
                <% end if %>
                <% if((Request.QueryString("unlock")) = "ok") then %>
                <div class="alert alert-success">                
                    <h4>Thành công!</h4>
                    Kích hoạt thành viên thành công. Thành viên này có thể tiếp tục hoạt động.
                </div> 
                <% end if %>
                <% if((Request.QueryString("delete")) = "ok") then %>
                <div class="alert alert-success">                
                    <h4>Thành công!</h4>
                    Xóa thành viên thành công.
                </div>
                <% end if %>
                <div class="row-fluid">

                    <div class="span12">                    
                        <div class="head clearfix">
                            <div class="isw-grid"></div>
                            <h1>Quản lý thành viên</h1>
                            <ul class="buttons">
                                <li class="toggle"><a href="#"></a></li>
                            </ul>                             
                        </div>
                        <div class="block-fluid table-sorting clearfix">
                            <table cellpadding="0" cellspacing="0" width="100%" class="table" id="example">
                                <thead>
                                    <tr>
                                    	<th>ID</th>
                                        <th>Tên đăng nhập</th>
                                        <th>Họ và tên</th>
                                        <th>Email</th>
                                        <th>Giới tính</th>  
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>                         
                                    </tr>
                                </thead>
                                <tbody>
  <% While ((Repeat1__numRows <> 0) AND (NOT rsKhachhang.EOF)) %>
    <tr>
      <td><%=(rsKhachhang.Fields.Item("ID").Value)%></td>
      <td><a href="thongtinthanhvien.asp?id=<%=(rsKhachhang.Fields.Item("ID").Value)%>"><%=(rsKhachhang.Fields.Item("TenDangNhap").Value)%></a></td>
      <td><%=(rsKhachhang.Fields.Item("HoTen").Value)%></td>
      <td><%=(rsKhachhang.Fields.Item("Email").Value)%></td>
      <td><% if(rsKhachhang.Fields.Item("GioiTinh").Value) = True Then
	  response.write("Nam")
	  Else
response.write("Nữ")
End If
%></td>
	<td><% if(rsKhachhang.Fields.Item("VaiTro").Value) = 1 Then
	  response.write("Quản trị viên")
	  Else
response.write("Thành viên")
End If
%></td>
      <td><% if(rsKhachhang.Fields.Item("TrangThai").Value) = 1 Then
	  response.write("Kích hoạt")
	  Else
response.write("Tạm khóa")
End If
%></td>
      <td><div class="btn-group" align="center">                                        
          <button data-toggle="dropdown" class="btn dropdown-toggle">Thao tác<span class="caret"></span></button>
          <ul class="dropdown-menu">
              <li><% if(rsKhachhang.Fields.Item("TrangThai").Value) = 1 Then %>
	  <a href="#preview_<%=(rsKhachhang.Fields.Item("ID").Value)%>" class="mails_show" data-toggle="modal" data-show="mail-1">Khóa</a>
<%	  Else %>
<a href="#preview_<%=(rsKhachhang.Fields.Item("ID").Value)%>" class="mails_show" data-toggle="modal" data-show="mail-1">Kích hoạt</a>
<% End If %>
</li>
                                                
              <li class="divider"></li>
                                                
              <li><a href="xoathanhvien.asp?id=<%=(rsKhachhang.Fields.Item("ID").Value)%>">Xóa</a></li>
          </ul>
          </div>
     </td>
    </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsKhachhang.MoveNext()
Wend
rsKhachhang.MoveFirst
%>
</tbody>
</table>
  <% While ((Repeat1__numRows <> 0) AND (NOT rsKhachhang.EOF)) %>
<div id="preview_<%=(rsKhachhang.Fields.Item("ID").Value)%>" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="myModalLabel">Khóa thành viên</h3>
            </div>        
            <div class="row-fluid">
            <div class="block-fluid">
            <div class="row-form clearfix">
                        <div class="span12" align="center"><h6>Bạn có chắc chắn muốn khóa thành viên này ?</h6></div>                    
            </div>
            <div class="row-form clearfix" align="center">
                        <div class="span12"><button class="btn btn-small tip" title="Hủy bỏ" data-dismiss="modal" aria-hidden="true">Hủy bỏ</button>
<% if(rsKhachhang.Fields.Item("TrangThai").Value) = 1 Then %>
	  <a href="suathanhvien.asp?id=<%=(rsKhachhang.Fields.Item("ID").Value)%>&action=lock">
<%	  Else %>
<a href="suathanhvien.asp?id=<%=(rsKhachhang.Fields.Item("ID").Value)%>&action=unlock">
<% End If
%>
                                <button class="btn btn-small tip" title="Đồng ý">Đồng ý</button></a></div>                    
            </div>
                </div>                                                        
            </div>
         </div>
                <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsKhachhang.MoveNext()
Wend
%>        
<!-- InstanceEndEditable -->
</div>
</div>
</body>
<!-- InstanceEnd --></html>
<%
rsKhachhang.Close()
Set rsKhachhang = Nothing
%>

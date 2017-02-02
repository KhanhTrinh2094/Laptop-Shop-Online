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
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "UPDATE dbo.tbTinTuc SET TieuDe = ?, NoiDung = ?, Anh = ? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 203, 1, 1073741823, Request.Form("txtTieude")) ' adLongVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 203, 1, 1073741823, Request.Form("wy")) ' adLongVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 500, Request.Form("txtLink")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "quanlytintuc.asp?update=ok"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
Dim rsTintuc__MMColParam
rsTintuc__MMColParam = "1"
If (Request.QueryString("ID") <> "") Then 
  rsTintuc__MMColParam = Request.QueryString("ID")
End If
%>
<%
Dim rsTintuc
Dim rsTintuc_cmd
Dim rsTintuc_numRows

Set rsTintuc_cmd = Server.CreateObject ("ADODB.Command")
rsTintuc_cmd.ActiveConnection = MM_cn_STRING
rsTintuc_cmd.CommandText = "SELECT * FROM dbo.tbTinTuc WHERE ID = ?" 
rsTintuc_cmd.Prepared = true
rsTintuc_cmd.Parameters.Append rsTintuc_cmd.CreateParameter("param1", 5, 1, -1, rsTintuc__MMColParam) ' adDouble

Set rsTintuc = rsTintuc_cmd.Execute
rsTintuc_numRows = 0
%>
<!DOCTYPE html>
<html lang="en"><!-- InstanceBegin template="/Templates/Template.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

    <title>Sửa tin tức</title>
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
<script language="javascript">
function cut_string() 
{ 
        var a= document.form1.txtImage.value; 
        var b= a.length; 
        var c= "\\"; 
        var d= a.lastIndexOf(c); 
        var e= a.substr(d+1,b); 
        document.form1.txtLink.value=e;
}
function kt()
{
	var txtTieude = document.form1.txtTieude.value.trim();
	var txtNoidung = document.form1.wy.value.trim();
	var txtLink = document.form1.txtLink.value.trim();
	var filename;
	var dotpos;
	filename = document.form1.txtLink.value;
	filename = filename.substring(filename.lastIndexOf("\\")+1,filename.length);
	dotpos=filename.lastIndexOf('.');
	ext=filename.substr(dotpos+1,3);
	ext=ext.toLowerCase();
	if(txtTieude.length == 0)
	{
		alert("Vui lòng nhập tiêu đề tin tức");
		document.form1.txtTieude.focus();
		return false;
	}
	else if(txtNoidung.length == 0)
	{
		alert("Vui lòng Nhập nội dung tin tức");
		document.form1.wy.focus();
		return false;
	}
	else if(txtLink.length == 0)
	{
		alert("Vui lòng chọn hình đại diện cho tin tức này");
		document.form1.txtLink.focus();
		return false;
	}
	else if ((ext!="gif") && (ext!="jpg") && (ext!="png")){
		alert("Bạn chỉ được UPLOAD những File định dạng GIF, JPG, PNG.");
		return false;
	}
	else{
		return true;
	}
}
</script>
                <div class="page-header">
                   <h1>Sửa tin tức</h1>
                </div>  
                
                <div class="row-fluid">

                    <div class="span12">
                        <div class="head clearfix">
                            <div class="isw-documents"></div>
                            <h1>Sửa tin tức</h1>
                        </div>

                        <div class="block-fluid">
<form action="<%=MM_editAction%>" method="POST" name="form1" onsubmit="return kt()">                        
                            <div class="row-form clearfix">
                                <div class="span3">Tiêu đề:</div>
                                <div class="span9"><input name="txtTieude" type="text" required id="txtTieude" placeholder="Nhập tiêu đề tin tức" value="<%=(rsTintuc.Fields.Item("TieuDe").Value)%>"/></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Nội dung:</div>
                              <div class="span9"><textarea id="wy" name="wy" style="height: 500px;" required><%=(rsTintuc.Fields.Item("NoiDung").Value)%></textarea></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Ảnh đại diện:</div>
                                <div class="span4">
                                  <img src="../thumb/Tintuc/<%=(rsTintuc.Fields.Item("Anh").Value)%>" alt="Tin tuc" /><br/>
                                  <input type="file" name="txtImage" id="txtImage" onchange="cut_string();">
                                  <input type="hidden" name="txtLink" id="txtLink" value="<%=(rsTintuc.Fields.Item("Anh").Value)%>">
                                </div>
                            </div>
                            <div class="footer tar">
                                <input type="submit" name="submit" id="submit" value="Submit" class="btn"/>
                            </div>
                            <input type="hidden" name="MM_insert" value="form1">
            <input type="hidden" name="MM_update" value="form1">
                            <input type="hidden" name="MM_recordId" value="<%= rsTintuc.Fields.Item("ID").Value %>">
</form>
    </div>
    </div>
    </div>
<!-- InstanceEndEditable -->
</div>
</div>
</body>
<!-- InstanceEnd --></html>
<%
rsTintuc.Close()
Set rsTintuc = Nothing
%>

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
    MM_editCmd.CommandText = "UPDATE dbo.tbSanPham SET TenSanPham = ?, Ram = ?, HDD = ?, Chip = ?, HSXID = ?, TrangThai = ?, ChiTiet = ?, GiaSanPham = ?, Anh = ? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 50, Request.Form("txtSanpham")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 201, 1, 50, Request.Form("txtRam")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 50, Request.Form("txtHdd")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 201, 1, 100, Request.Form("txtChip")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 5, 1, -1, MM_IIF(Request.Form("numHsx"), Request.Form("numHsx"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 5, 1, -1, MM_IIF(Request.Form("status"), Request.Form("status"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 203, 1, 1073741823, Request.Form("wy")) ' adLongVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 5, 1, -1, MM_IIF(Request.Form("numGia"), Request.Form("numGia"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 201, 1, 100, Request.Form("txtLink")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "quanlysanpham.asp?update=ok"
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
Dim rsSanPham__MMColParam
rsSanPham__MMColParam = "1"
If (Request.QueryString("ID") <> "") Then 
  rsSanPham__MMColParam = Request.QueryString("ID")
End If
%>
<%
Dim rsSanPham
Dim rsSanPham_cmd
Dim rsSanPham_numRows

Set rsSanPham_cmd = Server.CreateObject ("ADODB.Command")
rsSanPham_cmd.ActiveConnection = MM_cn_STRING
rsSanPham_cmd.CommandText = "SELECT * FROM dbo.tbSanPham WHERE ID = ?" 
rsSanPham_cmd.Prepared = true
rsSanPham_cmd.Parameters.Append rsSanPham_cmd.CreateParameter("param1", 5, 1, -1, rsSanPham__MMColParam) ' adDouble

Set rsSanPham = rsSanPham_cmd.Execute
rsSanPham_numRows = 0
%>
<%
Dim rsHSX
Dim rsHSX_cmd
Dim rsHSX_numRows

Set rsHSX_cmd = Server.CreateObject ("ADODB.Command")
rsHSX_cmd.ActiveConnection = MM_cn_STRING
rsHSX_cmd.CommandText = "SELECT ID, TenHang FROM dbo.tbHangSanXuat ORDER BY ID ASC" 
rsHSX_cmd.Prepared = true

Set rsHSX = rsHSX_cmd.Execute
rsHSX_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsSanPham_numRows = rsSanPham_numRows + Repeat1__numRows
%>
<!DOCTYPE html>
<html lang="en"><!-- InstanceBegin template="/Templates/Template.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

    <title>Sửa sản phẩm</title>
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
	var validSP = /^[a-zA-Z0-9-.\/_ ]{0,50}$/;
	var validChip = /^[a-zA-Z0-9-.\/_ ]{0,100}$/;
	var txtSanPham = document.form1.txtSanpham.value.trim();
	var numHsx = document.form1.numHsx.value.trim();
	var wysiwyg = document.form1.wy.value.trim();
	var txtChip = document.form1.txtChip.value.trim();
	var filename;
	var dotpos;
	filename = document.form1.txtLink.value;
	filename = filename.substring(filename.lastIndexOf("\\")+1,filename.length);
	dotpos=filename.lastIndexOf('.');
	ext=filename.substr(dotpos+1,3);
	ext=ext.toLowerCase();
	if(validChip.test(txtChip) == false)
	{
		alert("Loại Chip chỉ chứa chữ cái, số và tối đa 100 kí tự. Vui lòng nhập lại");
		document.form1.txtChip.focus();
		return false;
	}
	else if(validSP.test(txtSanPham) == false)
	{
		alert("Tên sản phẩm chỉ chứa chữ cái, số và tối đa 50 kí tự. Vui lòng nhập lại");
		document.form1.txtSanpham.focus();
		return false;
	}
	else if(document.form1.numHsx.value.length == 0)
	{
		alert("Vui lòng lựa chọn 1 hãng sản xuất");
		document.form1.numHsx.focus();
		return false;
	}
	else if(txtChip.length == 0)
	{
		alert("Vui lòng Nhập thông số Chip");
		document.form1.txtChip.focus();
		return false;
	}
	else if(txtSanPham.length == 0)
	{
		alert("Vui lòng Nhập tên sản phẩm");
		document.form1.txtSanpham.focus();
		return false;
	}
	else if(document.form1.status.value.length == 0)
	{
		alert("Vui lòng chọn trạng thái cho sản phẩm này");
		document.form1.status.focus();
		return false;
	}
	else if(wysiwyg.length == 0)
	{
		alert("Vui lòng nhập thông tin chi tiết cho sản phẩm này");
		document.form1.wy.focus();
		return false;
	}
	else if(document.form1.txtLink.value.length == 0)
	{
		alert("Vui lòng chọn ảnh đại diện cho sản phẩm này");
		document.form1.txtLink.focus();
		return false;
	}
	else if(document.form1.numGia.value <= 0)
	{
		alert("Giá sản phẩm không thể <= 0. Vui lòng nhập lại");
		document.form1.numGia.focus();
		return false;
	}
	else if ((ext!="gif") && (ext!="jpg") && (ext!="png")){
			alert("Bạn chỉ được UPLOAD những File định dạng GIF, JPG, PNG.");
			return false;
		}
	else {
		return true;
	}
}
</script>
                <div class="page-header">
                   <h1>Sửa sản phẩm</h1>
                </div>  
                
                <div class="row-fluid">

                    <div class="span12">
                        <div class="head clearfix">
                            <div class="isw-documents"></div>
                            <h1>Sửa sản phẩm</h1>
                        </div>
                        <div class="block-fluid">
<form action="<%=MM_editAction%>" method="POST" name="form1" onsubmit="return kt()">                        
                            <div class="row-form clearfix">
                                <div class="span3">Tên sản phẩm:</div>
                                <div class="span9"><input name="txtSanpham" type="text" required id="txtSanpham" placeholder="Nhập tên sản phẩm" value="<%=(rsSanPham.Fields.Item("TenSanPham").Value)%>"/></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Dung lượng Ram:</div>
                              <div class="span3"><input name="txtRam" type="text" required id="txtRam" value="<%=(rsSanPham.Fields.Item("Ram").Value)%>" /></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Dung lượng ổ đĩa:</div>
                                <div class="span3"><input name="txtHdd" type="text" required id="txtHdd" value="<%=(rsSanPham.Fields.Item("HDD").Value)%>" /></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Loại Chip:</div>
                                <div class="span9"><input name="txtChip" type="text" required id="txtChip" placeholder="Nhập loại Chip sử dụng" value="<%=(rsSanPham.Fields.Item("Chip").Value)%>"/></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Hãng sản xuất:</div>
                              <div class="span4">
                                <select name="numHsx" id="numHsx" multiple="multiple">
                                  <%
While (NOT rsHSX.EOF)
%>
                                  <option value="<%=(rsHSX.Fields.Item("ID").Value)%>" <%If (Not isNull((rsSanPham.Fields.Item("HSXID").Value))) Then If (CStr(rsHSX.Fields.Item("ID").Value) = CStr((rsSanPham.Fields.Item("HSXID").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(rsHSX.Fields.Item("TenHang").Value)%></option>
                                  <%
  rsHSX.MoveNext()
Wend
If (rsHSX.CursorType > 0) Then
  rsHSX.MoveFirst
Else
  rsHSX.Requery
End If
%>
                                </select>
                              </div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Trạng thái:</div>
                                <div class="span4">
                                <select name="status" id="status">
                                <% if((rsSanPham.Fields.Item("TrangThai").Value) = 1) Then %>
                                	<option value="1">Còn hàng</option>
                                    <option value="0">Hết hàng</option>
                                <%
								else
								%>
                                    <option value="0">Hết hàng</option>
                                	<option value="1">Còn hàng</option>
                                <% End If
                                %>
                                </select>
                               	</div>
                            </div>
                            
                            <div class="row-form clearfix">
                                <div class="span3">Chi tiết sản phẩm:</div>
                                <div class="span9">
                                  <textarea id="wy" name="wy" style="height: 500px;"><%=(rsSanPham.Fields.Item("ChiTiet").Value)%></textarea></div>
      </div>
                            
                            <div class="row-form clearfix">
                                <div class="span3">Giá sản phẩm:</div>
                                <div class="span4"><input name="numGia" type="number" required id="numGia" value="<%=(rsSanPham.Fields.Item("GiaSanPham").Value)%>" /></div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span3">Hình ảnh:</div>
                                <div class="span4">
                                	<img src="../thumb/<%=(rsSanPham.Fields.Item("Anh").Value)%>" alt="thumb" />
                                  <label for="txtImage"></label>
                                  <input type="file" name="txtImage" id="txtImage" onchange="cut_string();">
                                  <input type="hidden" name="txtLink" id="txtLink" value="<%=(rsSanPham.Fields.Item("Anh").Value)%>">
                                </div>
                            </div>
      <div class="footer tar">
                                <input type="submit" name="submit" id="submit" value="Submit" class="btn"/>
                            </div>
      <input type="hidden" name="MM_update" value="form1">
      <input type="hidden" name="MM_recordId" value="<%= rsSanPham.Fields.Item("ID").Value %>">
</form>
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
rsHSX.Close()
Set rsHSX = Nothing
%>

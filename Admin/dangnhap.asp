<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<%
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString <> "" Then MM_LoginAction = MM_LoginAction + "?" + Server.HTMLEncode(Request.QueryString)
MM_valUsername = CStr(Request.Form("txtuser"))
If MM_valUsername <> "" Then
  Dim MM_fldUserAuthorization
  Dim MM_redirectLoginSuccess
  Dim MM_redirectLoginFailed
  Dim MM_loginSQL
  Dim MM_rsUser
  Dim MM_rsUser_cmd
  
  MM_fldUserAuthorization = ""
  MM_redirectLoginSuccess = "index.asp"
  MM_redirectLoginFailed = "dangnhap.asp"

  MM_loginSQL = "SELECT TenDangNhap, MatKhau"
  If MM_fldUserAuthorization <> "" Then MM_loginSQL = MM_loginSQL & "," & MM_fldUserAuthorization
  MM_loginSQL = MM_loginSQL & " FROM dbo.tbKhachHang WHERE TenDangNhap = ? AND MatKhau = ? AND VaiTro = 1"
  Set MM_rsUser_cmd = Server.CreateObject ("ADODB.Command")
  MM_rsUser_cmd.ActiveConnection = MM_cn_STRING
  MM_rsUser_cmd.CommandText = MM_loginSQL
  MM_rsUser_cmd.Parameters.Append MM_rsUser_cmd.CreateParameter("param1", 200, 1, 20, MM_valUsername) ' adVarChar
  MM_rsUser_cmd.Parameters.Append MM_rsUser_cmd.CreateParameter("param2", 200, 1, 20, Request.Form("txtpass")) ' adVarChar
  MM_rsUser_cmd.Prepared = true
  Set MM_rsUser = MM_rsUser_cmd.Execute

  If Not MM_rsUser.EOF Or Not MM_rsUser.BOF Then 
    ' username and password match - this is a valid user
    Session("MM_Username") = MM_valUsername
    If (MM_fldUserAuthorization <> "") Then
      Session("MM_UserAuthorization") = CStr(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value)
    Else
      Session("MM_UserAuthorization") = ""
    End If
    if CStr(Request.QueryString("accessdenied")) <> "" And false Then
      MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    End If
    MM_rsUser.Close
    Response.Redirect(MM_redirectLoginSuccess)
  End If
  MM_rsUser.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
If((Session("MM_Username") <> "")) Then Response.Redirect("index.asp")
%>
<!DOCTYPE html>
<html lang="en">
<head>        
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <!--[if gt IE 8]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <![endif]-->
    
    <title>Đăng nhập</title>

    <link rel="icon" type="image/ico" href="favicon.ico"/>
    
    <link href="css/stylesheets.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 8]>
        <link href="css/ie7.css" rel="stylesheet" type="text/css" />
    <![endif]-->    
    <link rel='stylesheet' type='text/css' href='css/fullcalendar.print.css' media='print' />
    
    <script type='text/javascript' src='js/plugins/jquery/jquery-1.10.2.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery-ui-1.10.1.custom.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery-migrate-1.2.1.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery.mousewheel.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/cookie/jquery.cookies.2.2.0.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/bootstrap.min.js'></script>
    
    <script type='text/javascript' src='js/plugins/charts/excanvas.min.js'></script>
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
    <script language="javascript" type="text/javascript">
	function check_form_login()
	{
		if(document.frm_login.txtuser.value.length==0)
		{
			alert("Tên đăng nhập không được rỗng.")
			document.frm_login.txtuser.focus()
			return false
		}
		if(document.frm_login.txtpass.value.length==0)
		{
			alert("Mật khẩu không được rỗng.")
			document.frm_login.txtpass.focus()
			return false
		}
		return true
	}
</script>
</head>
<body onload="javascript:document.frm_login.txtuser.focus()">

<!--
    <div class="loginBlock" id="login" style="display: block;">
        <h1>Chào mừng. Hãy đăng nhập</h1>
        <div class="dr"><span></span></div>
        <div class="loginForm">
<form id="form1" name="frm_login" method="POST" action="<%=MM_LoginAction%>" onsubmit="return check_form_login()">
                <div class="control-group">
                    <div class="input-prepend">
                        <span class="add-on"><span class="icon-envelope"></span></span>
            <input name="txtuser" type="text" id="txtuser" />
                    </div>                
                </div>
                <div class="control-group">
                    <div class="input-prepend">
                        <span class="add-on"><span class="icon-lock"></span></span>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span8">
                        <div class="control-group" style="margin-top: 5px;">
                            <label class="checkbox"><input type="checkbox"> Remember me</label>                                                
                        </div>                    
                    </div>
                    <div class="span4">
                        <button type="submit" class="btn btn-block">Sign in</button>       
                    </div>
                </div>

   </form>
 -->
     
    <div class="loginBlock" id="login" style="display: block;">
        <h1>Vui lòng đăng nhập !</h1>
        <div class="loginForm">
            <form class="form-horizontal" action="<%=MM_LoginAction%>" method="POST" id="frm_login" name="frm_login" onsubmit="return check_form_login()">
                <div class="control-group">
                    <div class="input-prepend">
                        <span class="add-on"><span class="icon-envelope"></span></span>
                        <input type="text" id="txtuser" name="txtuser" placeholder="User" />
                    </div>                
                </div>
                <div class="control-group">
                    <div class="input-prepend">
                        <span class="add-on"><span class="icon-lock"></span></span>
                        <input type="password" id="txtpass" name="txtpass" placeholder="Password" />
                    </div>
                </div>
                <div class="row-fluid">
                    <div align="center">
                        <button type="submit" class="btn btn-block">Sign in</button>       
                    </div>
                </div>
            </form>  
            <div class="dr"><span></span></div>
            <div class="controls">
                <div class="row-fluid">
                    <div class="span6">
                        <button class="btn btn-link btn-block" onClick="../index.asp">Trang chủ</button>
                    </div>
                    <div class="span2"></div>
                    <div class="span4">
                        <button class="btn btn-link btn-block" onClick="../index.asp">Thoát</button>
                    </div>
                </div>
            </div>
        </div>
    </div>    
    
</body>
</html>

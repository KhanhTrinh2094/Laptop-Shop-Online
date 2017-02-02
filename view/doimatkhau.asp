<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<div class="leadmhome_in">Đổi mật khẩu</div>
<form id="form1" name="form1" method="post" action="" class="frm_submit">
<center>
  <table width="400" border="0">
    <tr>
      <td >Mật khẩu cũ </td>
      <td ><input name="mku" type="password" id="mku" size="30"/></td>
      <div class="ckxog"></div>
    </tr>
    <tr>
      <td>Mật khẩu mới </td>
      <td><input name="mkun" type="password" id="mkun" size="30"/></td>
    </tr>
    <tr>
      <td>Xác nhận mật khẩu </td>
      <td><input name="rmku" type="password" id="rmku" size="30"/></td>
    </tr>
  </table>
 <div style="width:200">
   

    <span class="xoa" id="change">Xác nhận</span>
 </div>
  </center>
</form>
<%
if(Request.ServerVariables("REQUEST_METHOD")= "GET" AND (Request.QueryString("mku")) <> "") then
%>
<%
Dim rsMatkhau__MMColParam
rsMatkhau__MMColParam = "1"
If (Session("user") <> "") Then 
  rsMatkhau__MMColParam = Session("user")
End If
%>
<%
Dim rsMatkhau
Dim rsMatkhau_cmd
Dim rsMatkhau_numRows

Set rsMatkhau_cmd = Server.CreateObject ("ADODB.Command")
rsMatkhau_cmd.ActiveConnection = MM_cn_STRING
rsMatkhau_cmd.CommandText = "SELECT MatKhau FROM dbo.tbKhachHang WHERE TenDangNhap = ?" 
rsMatkhau_cmd.Prepared = true
rsMatkhau_cmd.Parameters.Append rsMatkhau_cmd.CreateParameter("param1", 200, 1, 20, rsMatkhau__MMColParam) ' adVarChar

Set rsMatkhau = rsMatkhau_cmd.Execute
rsMatkhau_numRows = 0
%>
<% if((rsMatkhau.Fields.Item("MatKhau").Value) = (Request.QueryString("mku"))) then
    Dim MM_editCmd
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "UPDATE dbo.tbKhachHang SET MatKhau = ? WHERE TenDangNhap = ?" 
    MM_editCmd.Prepared = true
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 20, (Request.QueryString("mkun"))) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 200, 1, 20, rsMatkhau__MMColParam) ' adVarWChar
    MM_editCmd.Execute
%>
<script>alert("Đổi mật khẩu thành công");location="?";</script>
<% else %>
<script>alert("Mật khẩu cũ không đúng");</script>
<% end If %>
<%
rsMatkhau.Close()
Set rsMatkhau = Nothing
%>
<% end if %>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<%
Dim rsThanhvien__MMColParam
rsThanhvien__MMColParam = "1"
If (Session("user") <> "") Then 
  rsThanhvien__MMColParam = Session("user")
End If
%>
<%
Dim rsThanhvien
Dim rsThanhvien_cmd
Dim rsThanhvien_numRows

Set rsThanhvien_cmd = Server.CreateObject ("ADODB.Command")
rsThanhvien_cmd.ActiveConnection = MM_cn_STRING
rsThanhvien_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang WHERE TenDangNhap = ?" 
rsThanhvien_cmd.Prepared = true
rsThanhvien_cmd.Parameters.Append rsThanhvien_cmd.CreateParameter("param1", 200, 1, 20, rsThanhvien__MMColParam) ' adVarChar

Set rsThanhvien = rsThanhvien_cmd.Execute
rsThanhvien_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsThanhvien_numRows = rsThanhvien_numRows + Repeat1__numRows
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<div class="anxem">
  <div class="leadmhome_in">Thông tin cá nhân</div>
<table width="622" height="400" border="0" style="padding:10px">
  <tr>
    <td width="102"><span class="style5">Họ tên </span></td>
    <td width="465"><div align="center"><span class="style5"><%=(rsThanhvien.Fields.Item("HoTen").Value)%></span></div></td>
    <td width="41"><div align="center"><span class="xoa" id="editus" user="">Sửa</span></div></td>
  </tr>
  <tr>
    <td><span class="style5">Tên đăng nhập</span></td>
    <td><div align="center"><span class="style5"><%=(rsThanhvien.Fields.Item("TenDangNhap").Value)%></span></div></td>
  </tr>
  <tr>
    <td><span class="style5">Địa chỉ</span></td>
    <td><div align="center"><span class="style5"><%=(rsThanhvien.Fields.Item("DiaChi").Value)%></span></div></td>
    
  </tr>
  <tr>
    <td><span class="style5">Email</span></td>
    <td><div align="center"><span class="style5"><%=(rsThanhvien.Fields.Item("Email").Value)%></span></div></td>
    
  </tr>
  <tr>
    <td><span class="style5">Số điện thoại</span></td>
    <td><div align="center"><span class="style5"><%=(rsThanhvien.Fields.Item("SoDienThoai").Value)%></span></div></td>
   
  </tr>
  <tr>
    <td><span class="style5">Giới tính</span></td>
    <td><div align="center"><span class="style5">
    
        <% if(rsThanhvien.Fields.Item("GioiTinh").Value = 1) then %>
          Nam
         
         
        <% else %>
          Nữ
<% end if %>
    </span></div></td>
      </tr>
  <tr>
    <td><span class="style5">Chức vụ</span></td>
        <td><div align="center"><span class="style5">
    
        <% if(rsThanhvien.Fields.Item("VaiTro").Value = 1) then %>
          Người quản trị
         
         
        <% else %>
          Thành viên
<% end if %>
    </span></div></td>
  </tr>
</table>
</div></<div>
</body>
</html>
<%
rsThanhvien.Close()
Set rsThanhvien = Nothing
%>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<div id="angiohang">
<div id="an2">
<div class="leadmhome_in">Giỏ hàng của bạn</div>
<%
Dim giohang
Dim masp
Dim soluong
Dim menu
Dim sanpham
Dim rsHsx
Dim rsHsx_cmd
Dim Gia4 (10)
' Tao gio hang
If IsObject(Session("giohang")) Then
	Set giohang = Session("giohang")
Else
	Set giohang = Server.CreateObject("Scripting.Dictionary")
End If

' Tao thong tin san pham
If IsObject(Session("sanpham")) Then
	Set sanpham = Session("sanpham")
Else
	Set sanpham = Server.CreateObject("Scripting.Dictionary")
End If

' Ham them vao gio hang
Function Add(iItemID)
 	If giohang.Exists(iItemID) Then
		giohang(iItemID) = giohang(iItemID) + 1
	Else
		giohang.Add iItemID, 1
	End If
	SET Session("giohang") = giohang

Set rsHsx_cmd = Server.CreateObject ("ADODB.Command")
rsHsx_cmd.ActiveConnection = MM_cn_STRING
rsHsx_cmd.CommandText = "SELECT TenSanPham, GiaSanPham, ID, Anh FROM dbo.tbSanPham WHERE ID = ?" 
rsHsx_cmd.Prepared = true
rsHsx_cmd.Parameters.Append rsHsx_cmd.CreateParameter("param1", 5, 1, 20, iItemID)
Set rsHsx = rsHsx_cmd.Execute

	If sanpham.Exists(iItemID) Then
	else
	sanpham.Add iItemID, Array((rsHsx.Fields.Item("ID").Value), (rsHsx.Fields.Item("TenSanPham").Value), (rsHsx.Fields.Item("Anh").Value), (rsHsx.Fields.Item("GiaSanPham").Value))
	end if
	
	SET Session("sanpham") = sanpham
End Function

Function Gia(Giathanh)
		Gia1 = CSTR(Giathanh)
		Gia2 = len(Gia1)
		Gia4(0) = Mid(Gia1, 5, 3)
		Gia4(2) = Mid(Gia1, 1, Gia2-6)
		Gia4(1) = Mid(Gia1, 2, 3)
		Response.Write(Gia4(2) & "." & Gia4(1) & "." & Gia4(0))
End Function

menu = CStr(Request.QueryString("actions"))
masp = CInt(Request.QueryString("sp"))
soluong = 1
Select Case menu
	Case "mua"
		Add(masp)
	Case "xoahet"
		Session.Contents.Remove("giohang")
		Session.Contents.Remove("sanpham")
	Case "xoa"
		giohang.Remove masp
		sanpham.Remove masp
		if(giohang.Count = 0) then
			Session.Contents.Remove("giohang")
			Session.Contents.Remove("sanpham")
		end if
	Case Else %>
<%

' Tao gio hang
If IsObject(Session("giohang")) Then
	Set giohang = Session("giohang")
Else
	Set giohang = Server.CreateObject("Scripting.Dictionary")
End If
' Tao thong tin san pham
If IsObject(Session("sanpham")) Then
	Set sanpham = Session("sanpham")
Else
	Set sanpham = Server.CreateObject("Scripting.Dictionary")
End If
if(IsObject(Session("giohang"))) then
%>
    <table width="750" height="200" border="0">
  <tr style="color:red">
    <td><div align="center">Tên sản phẩm</div></td>
    <td><div align="center">Giá</div></td>
    <td><div align="center">Số lượng</div></td>
    <td><div align="center">Thành tiền</div></td>
    <td colspan="2"><div align="center">Hành động</div></td>
  </tr>
<%
Dim i
Dim Dem
Dem = 0
Dim Tonggiatri
Tonggiatri = 0
For Each i in giohang
Tonggiatri = Tonggiatri + sanpham (i) (3) * giohang(i)
%>

  <tr>
    <td align="center"><img width="80" height="80" src="thumb/<%=sanpham (i) (2)%>"/><br><%=sanpham (i) (1)%></td>
    <td align="center"><%=Gia(sanpham (i) (3))%> VND</td>

    <td align="center"><input name="<%=sanpham (i) (0)%>" id="soluong"  size="3" value="<%=giohang(i)%>" align="center" style="font-family:g2" maxlength="2"/></td>
   
    
    <td align="center"><%=Gia(sanpham (i) (3) * giohang(i))%> VND</td>
    
    <td align="center"><span class="xoa" id="del" del="<%=sanpham (i) (0)%>">Xóa</span></td>
  </tr>
<%
Dem = Dem + 1
next
%>
</table>
 <p align="right" style="font-size=30; color:red;font-weight:bold; padding: 10px;">Tổng tiền: <%=Gia(Tonggiatri)%> VND</p>
    
<p style="color:red; font-weight:bold;  padding: 10px;">Bạn có <%=Dem%> sản phẩm trong giỏ hàng</p><br/>

<div style="width:600 ;height:20;  padding: 10px;">
    <span id="sub" class="xoa" align="center">Xóa hết</span>
    <span class="xoa" align="center" id="thanhtoan">Thanh toán</span>
    <span align="right" id="loadupdat"></span>
</div>
</div>
</div>
<% else %>
<p style="color:red; padding: 10px;">Bạn không có sản phẩm nào trong giỏ hàng</p>
<% end if %>
<% End select
%>
</div>
<div class="xoahet"></div>
</div>
<div class="thanhtoan"></div>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" --> 
<% if(Request.ServerVariables("REQUEST_METHOD")= "GET") then
    Dim MM_editCmd
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "INSERT INTO dbo.tbHoaDon (KHID, ThoiGian, NgayGiaoHang, TenNguoiNhan, GioiTinh, DiaChi, Email, DienThoai, GhiChu, TrangThai) VALUES (?, default, CONVERT(DATETIME, ?), ?, ?, ?, ?, ?, ?, ?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 3, 1, 20, Request.QueryString("user")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 200, 1, 50, Request.QueryString("ngaygiao")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 300, Request.QueryString("hoten")) ' adLongVarChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 3, 1, 11, Request.QueryString("gt")) ' adLongVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 300, Request.QueryString("diachi")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 200, 1, 300, Request.QueryString("mail")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 3, 1, 11, Request.QueryString("dienthoai")) ' adLongVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 203, 1, 3000, Request.QueryString("yc")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 3, 1, -1, 0) ' adLongVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

	Dim rsHoadon
	Dim rsHoadon_cmd
	Set rsHoadon_cmd = Server.CreateObject ("ADODB.Command")
	rsHoadon_cmd.ActiveConnection = MM_cn_STRING
	rsHoadon_cmd.CommandText = "SELECT TOP 1 ID FROM dbo.tbHoadon WHERE KHID = ? ORDER BY ID DESC" 
	rsHoadon_cmd.Prepared = true
	rsHoadon_Cmd.Parameters.Append rsHoadon_Cmd.CreateParameter("param1", 3, 1, 20, Request.QueryString("user")) ' adVarWChar
	Set rsHoadon = rsHoadon_cmd.Execute
	Dim giohang
	Set giohang = Session("giohang")
	For Each i in giohang
		    Dim MM_InsertCmd
    Set MM_InsertCmd = Server.CreateObject ("ADODB.Command")
    MM_InsertCmd.ActiveConnection = MM_cn_STRING
    MM_InsertCmd.CommandText = "INSERT INTO dbo.tbDatHang (SPID, HDID, SoLuong, TrangThai) VALUES (?, ?, ?, ?)" 
    MM_InsertCmd.Prepared = true
    MM_InsertCmd.Parameters.Append MM_InsertCmd.CreateParameter("param1", 3, 1, 20, i) ' adVarWChar
    MM_InsertCmd.Parameters.Append MM_InsertCmd.CreateParameter("param2", 3, 1, 20, (rsHoadon.Fields.Item("ID").Value)) ' adLongVarChar
    MM_InsertCmd.Parameters.Append MM_InsertCmd.CreateParameter("param3", 3, 1, 20, giohang(i)) ' adLongVarChar
    MM_InsertCmd.Parameters.Append MM_InsertCmd.CreateParameter("param4", 3, 1, -1, 0) ' adLongVarChar
    MM_InsertCmd.Execute
    MM_InsertCmd.ActiveConnection.Close
	NEXT
	Session.Contents.Remove("sanpham")
	Session.Contents.Remove("giohang")	
	Response.Write("Giao Dich ThÀnh CÔng")
End If
%>

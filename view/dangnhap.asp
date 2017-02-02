<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->


<%
Dim rsKiemtraid
Dim rsKiemtraid_cmd
Dim rsKiemtraid_numRows

Set rsKiemtraid_cmd = Server.CreateObject ("ADODB.Command")
rsKiemtraid_cmd.ActiveConnection = MM_cn_STRING
rsKiemtraid_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang WHERE TenDangNhap = ? AND MatKhau = ? AND TrangThai = 1" 
rsKiemtraid_cmd.Prepared = true
rsKiemtraid_cmd.Parameters.Append rsKiemtraid_cmd.CreateParameter("param1", 200, 1, 255, Request.QueryString("tendangnhap")) ' adDouble
rsKiemtraid_cmd.Parameters.Append rsKiemtraid_cmd.CreateParameter("param1", 200, 1, 255, Request.QueryString("matkhau")) ' adDouble

Set rsKiemtraid = rsKiemtraid_cmd.Execute
rsKiemtraid_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 10
Repeat1__index = 0
rsKiemtraid_numRows = rsKiemtraid_numRows + Repeat1__numRows
%>
<%
'  *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

Dim rsKiemtraid_total
Dim rsKiemtraid_first
Dim rsKiemtraid_last

' set the record count
rsKiemtraid_total = rsKiemtraid.RecordCount

' set the number of rows displayed on this page
If (rsKiemtraid_numRows < 0) Then
  rsKiemtraid_numRows = rsKiemtraid_total
Elseif (rsKiemtraid_numRows = 0) Then
  rsKiemtraid_numRows = 1
End If

' set the first and last displayed record
rsKiemtraid_first = 1
rsKiemtraid_last  = rsKiemtraid_first + rsKiemtraid_numRows - 1

' if we have the correct record count, check the other stats
If (rsKiemtraid_total <> -1) Then
  If (rsKiemtraid_first > rsKiemtraid_total) Then
    rsKiemtraid_first = rsKiemtraid_total
  End If
  If (rsKiemtraid_last > rsKiemtraid_total) Then
    rsKiemtraid_last = rsKiemtraid_total
  End If
  If (rsKiemtraid_numRows > rsKiemtraid_total) Then
    rsKiemtraid_numRows = rsKiemtraid_total
  End If
End If
%>
<%
Dim MM_paramName 
%>
<%
' *** Move To Record and Go To Record: declare variables

Dim MM_rs
Dim MM_rsCount
Dim MM_size
Dim MM_uniqueCol
Dim MM_offset
Dim MM_atTotal
Dim MM_paramIsDefined

Dim MM_param
Dim MM_index

Set MM_rs    = rsKiemtraid
MM_rsCount   = rsKiemtraid_total
MM_size      = rsKiemtraid_numRows

%>

<%
' *** Move To Record: if we dont know the record count, check the display range

If (MM_rsCount = -1) Then

  ' walk to the end of the display range for this page
  MM_index = MM_offset
  While (Not MM_rs.EOF And (MM_size < 0 Or MM_index < MM_offset + MM_size))
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend

  ' if we walked off the end of the recordset, set MM_rsCount and MM_size
  If (MM_rs.EOF) Then
    MM_rsCount = MM_index
    If (MM_size < 0 Or MM_size > MM_rsCount) Then
      MM_size = MM_rsCount
    End If
  End If

  ' if we walked off the end, set the offset based on page size
  If (MM_rs.EOF And Not MM_paramIsDefined) Then
    If (MM_offset > MM_rsCount - MM_size Or MM_offset = -1) Then
      If ((MM_rsCount Mod MM_size) > 0) Then
        MM_offset = MM_rsCount - (MM_rsCount Mod MM_size)
      Else
        MM_offset = MM_rsCount - MM_size
      End If
    End If
  End If

  ' reset the cursor to the beginning
  If (MM_rs.CursorType > 0) Then
    MM_rs.MoveFirst
  Else
    MM_rs.Requery
  End If

  ' move the cursor to the selected record
  MM_index = 0
  While (Not MM_rs.EOF And MM_index < MM_offset)
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend
End If
%>

<%
if ((MM_rsCount) > 0) then
Session("user") = Request.QueryString("tendangnhap")
Session("role") = (rsKiemtraid.Fields.Item("VaiTro").Value)
%>
<div class="tt" tt="1"></div>
<%
else
%>
<script>alert('Sai tên đăng nhập hoặc mật khẩu !!!');</script>
<%
end if
%>
<%
rsKiemtraid.Close()
Set rsKiemtraid = Nothing
%>

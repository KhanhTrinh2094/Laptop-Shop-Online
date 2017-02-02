<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<%
Dim rsKhachhang__MMColParam
rsKhachhang__MMColParam = "1"
If (Session("user") <> "") Then 
  rsKhachhang__MMColParam = Session("user")
End If
%>
<%
Dim rsKhachhang
Dim rsKhachhang_cmd
Dim rsKhachhang_numRows

Set rsKhachhang_cmd = Server.CreateObject ("ADODB.Command")
rsKhachhang_cmd.ActiveConnection = MM_cn_STRING
rsKhachhang_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang WHERE TenDangNhap = ?" 
rsKhachhang_cmd.Prepared = true
rsKhachhang_cmd.Parameters.Append rsKhachhang_cmd.CreateParameter("param1", 200, 1, 20, rsKhachhang__MMColParam) ' adVarChar

Set rsKhachhang = rsKhachhang_cmd.Execute
rsKhachhang_numRows = 0
%>
<div class="leadmhome_in">Thanh toán</div>
<%
if((session("user") <> "") AND (IsObject(session("giohang")) = true) AND (IsObject(session("sanpham")) = true)) then
%>
<div class="mak" align="right" user="<%=(rsKhachhang.Fields.Item("ID").Value)%>" style="color:red;font-style:italic;font-family:g2; font-size:15; padding: 10px">Mã khách hàng của bạn là: <%=(rsKhachhang.Fields.Item("ID").Value)%></div>

 <div style="padding:10" id="frmdel">
 <form name="form8" method="post" id="form8">
    <div align="center" style="font-style:italic;font-weight:bold;font-size:17;color:red">Thông tin người nhận hàng</div>
 <table class="frm_submit" style="font-size: 12px; padding: 10px;">
 <tr>
                    <td>Họ tên</td><td><input type="text" size="50" name="hoten" id="hoten" value="<%=(rsKhachhang.Fields.Item("HoTen").Value)%>" /></td>
                </tr>
                <tr>
                    <td>Giới tính</td><td><select name="gt" id="gt">
                    <option value="1">Nam</option>
                    <option value="0">Nữ</option>
                    <option value="2">Khác</option>
                    </select></td>
                </tr>
                <tr>
                    <td>Địa chỉ Email</td><td><input type="text" name="mail" size="50" id="mail" value="<%=(rsKhachhang.Fields.Item("Email").Value)%>" /></td>
                </tr>
                <tr>
                    <td>Điện thoại</td><td><input type="text" size="20" name="dienthoai" id="dienthoai" value="0<%=(rsKhachhang.Fields.Item("SoDienThoai").Value)%>"/></td>
                </tr>
                <tr>
                    <td>Địa chỉ</td><td><textarea cols="40" rows="2" name="diachi" id="diachi"><%=(rsKhachhang.Fields.Item("DiaChi").Value)%></textarea></td>
                </tr>
                <tr>
                    <td>Ngày giao hàng</td><td><input size="20" name="ngaygiao" id="ngaygiao" value="yyyymmdd"/></td>
                </tr>
                <tr>
                    <td>Yêu cầu thêm</td><td><textarea cols="40" rows="5" name="yc" id="yc"></textarea></td>
                </tr>
            </table>
            <br />
           <br/>
            <div align="left"><span class="xoa" id="guidon">Gửi đơn hàng</span></div>
            <div id="loadxemtruoc" align="center"></div>
            </div>
            
    </div>

        </form>
    </form>
 </div>

 <div class="guixong" style="color: red; font-style: italic; font-size:20" align="center"></div>
<span id="datenow" date="<% response.write(Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())) %>"></span>
<% else %>
<p style="color:red; padding: 10px;">Vui lòng thử lại</p>
<% end if %>
<%
rsKhachhang.Close()
Set rsKhachhang = Nothing
%>

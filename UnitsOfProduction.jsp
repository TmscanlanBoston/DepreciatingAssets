<html>
	<head>
		<title>Input for Units</title>
		<link href="Style.css" rel="stylesheet" type="text/css">
	</head>  
	<body bgcolor="BLACK">
	<br>
<%	int life =  (int)Double.parseDouble(request.getParameter("ulBox"));
	double cost = Double.parseDouble(request.getParameter("costBox"));
	double scrap = Double.parseDouble(request.getParameter("scrapBox"));
	
	if (cost > scrap && life > 0 && cost > 0 && scrap > 0) {	 %>
		<table width="50%" align="CENTER" cellpadding="15" border="15" bgcolor="CCFFFF">
			<tr> <td>
				<center> <h1>Units of Production Input</h1> </center>
			</td> </tr>
		</table>
		<table width="50%" align="CENTER" cellpadding="15" border="2" bgcolor="9999FF">
			<th><h2>Useful Life: <%= life%></h2></th>
			<th><h2>Cost: <%= String.format("$%.2f", cost)%></h2></th>
			<th><h2>Scrap: <%= String.format("$%.2f",scrap)%></h2></th>
		</table>
		<form action= "UnitCalculationAndTable.jsp" method="POST">
			<table width="50%" align="CENTER" cellpadding="15" border="2" bgcolor="9999FF"> 
			<td colspan="5" align="CENTER" >
				<h2> Please enter the anticipated number of units for the assets useful life</h2>
				<h2> Anticipated Units: <input type="TEXT" name="anticipatedUnits" value="" required="REQUIRED"></h2>
			</td>
			</table>
			<table width = "50%" align = "CENTER" cellpadding="15" border="2" bgcolor="6633FF">	
<%		out.write("<tr align=\"CENTER\"><td><h2>Please enter the number of units for each year of the assets useful life</h2></td></tr>");
		for (int i = 1; i <= life; i++) 
		{ 
			out.write("<tr align=\"CENTER\"><td>Year " + i + " <input type = \"TEXT\" name=\"inputBox"+ i +"\" value=\"\" required=\"REQUIRED\"></td></tr>");
		}	%>
				<tr align="CENTER"><td><input type="submit" class="btn-style" value="Submit"></td></tr>
			</table>
			<input type="hidden" name="life" value= <%= life%> >
			<input type="hidden" name="cost" value= <%= cost%> >
			<input type="hidden" name="scrap" value= <%= scrap%> >
		</form>
<% 	}
	else { %>
		<table width = "50%" align = "CENTER" cellpadding="15" border="2" bgcolor="FF9999">	
			<tr align="CENTER">
				<td><h1> 
					<%= cost <= scrap ? "ERROR!!! Scrap cannot exceed or be equal to Cost" : "No values can be negative or equal to zero!" %>
				</h1></td>
			</tr>
			<tr align="CENTER"><td><h1> Please start over! </h1></td></tr>
			<form action="DepreciatingAsset.html">
				<tr align="CENTER"><td><input type="submit" class="btn-style" value="Start-Over"></td></tr>
			</form>
		</table>
<%  } %>
	</body>
</html>
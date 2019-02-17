<html>
	<head>
		<title>Units Of Production Table</title>
		<link href="Style.css" rel="stylesheet" type="text/css">
	</head>
	<body bgcolor="BLACK">
	<br>
<%	try {
		int useLife = Integer.parseInt(request.getParameter("life"));
		double costUp = Double.parseDouble(request.getParameter("cost"));
		double scrapUp = Double.parseDouble(request.getParameter("scrap"));
		double maxDepreciationUp = costUp-scrapUp;
		double accumDepreciation = 0;
		double anticipatedUnits = Double.parseDouble(request.getParameter("anticipatedUnits"));
		double [] yearsData = new double [useLife];
		double [] valPerYear = new double [useLife];
		double sumYears = 0;
		double singleUnitVal = maxDepreciationUp/anticipatedUnits;
		
		for (int boxNum = 1, i = 0; i < useLife; i++, boxNum++) 
		{
			yearsData[i]= Double.parseDouble(request.getParameter("inputBox" + boxNum));
			valPerYear[i]= singleUnitVal * yearsData[i];
			sumYears += yearsData[i];
		}
		
		if (anticipatedUnits <= 0 ) { %>
			<br>
				<table width="86%"  align="CENTER" cellpadding="10" border="10" bgcolor="FF9999">
					<td align="CENTER">
						<h1> Anticipated Units cannot be equal to or less than zero! <h1>
					</td>
				</table>
<%		}
		else if (sumYears > anticipatedUnits || sumYears < anticipatedUnits)
		{  %>
			<br>
				<table width="86%"  align="CENTER" cellpadding="10" border="10" bgcolor="FF9999">
					<td align="CENTER">
						<h1> You have <%= sumYears > anticipatedUnits ? "exceeded" : "fallen short of" %> the anticipated Units. Please Try again! <h1>
					</td>
				</table>
<%		}
		else 
		{ 	%>	
			<table width="86%" align="CENTER" cellpadding="15" border="15" bgcolor="CCFFFF">
				<tr><td>
					<center><h1>Units Of Production Table</h1></center>
				</td></tr>
			</table>			
			<table width="86%"  align="CENTER" cellpadding="10" border="10" cellspacing="5" bgcolor="WHITE">
			<tr>
				<tr align="CENTER">		
					<td><h1> Useful Life:  <%= useLife%> </h1></td>
					<td><h1> Cost:  <%= String.format("$%.2f",costUp)%> </h1></td>
					<td><h1> Scrap:  <%= String.format("$%.2f",scrapUp)%> </h1></td>
					<td><h1> Single Unit Value: <%= String.format("$%.2f",singleUnitVal)%> </h1></td>
				</tr>
				<th><h1>Years</h1></th>
				<th><h1>Units</h1></th>
				<th><h1>Depreciation</h1></th>
				<th><h1>Accum.Depreciation</h1></th>
<%			for (int i = 1; i <= useLife; i++ ) 
			{	
				out.println("<tr align=\"CENTER\"><td>" + i + "</td>");
				out.println("<td>" + yearsData[i-1] + "</font></td>");
				out.println("<td>" + String.format("$%.2f",valPerYear[i-1]) + "</td>");
				accumDepreciation += valPerYear[i-1];
				out.println("<td>" + String.format("$%.2f",accumDepreciation) + "</td></tr>");
			}	%>
			</table>
<%		}
	}
	catch (NumberFormatException nfe) 
	{	 %>
		<table width="86%" align="CENTER" cellpadding="10" border="2" cellspacing="5" bgcolor="FF9999">
			<tr align="CENTER"><td><h1> I warned you about Non-Numeric Input! </h1></td></tr>
			<tr align="CENTER"><td><h1> Now we gotta start all over again! 0_o </h1></td></tr>
		</table>
<%	} 	
	catch (NegativeArraySizeException nase) 
	{	%>
		<table width="86%" align="CENTER" cellpadding="10" border="2" cellspacing="5" bgcolor="FF9999">
			<tr align="CENTER"><td><h1> Please do not make life a negative value! </h1></td></tr>
			<tr align="CENTER"><td><h1> Now we gotta start all over again! 0_o </h1></td></tr>
		</table>
<%  }   %>
	<table width="86%"  align="CENTER" cellpadding="10" border="2" cellspacing="5" bgcolor="0099CC">	
		<form action= "DepreciatingAsset.html" method="POST">
			<tr align="CENTER"><td><input type="submit" class="btn-style" value="Start-Over"></td></tr>
		</form>
	</table>
	</body>
</html>
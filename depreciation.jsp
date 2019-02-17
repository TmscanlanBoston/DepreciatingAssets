<html> 
	<head> 
		<title>Depreciation Tables</title>
		<link href="Style.css" rel="stylesheet" type="text/css">
	</head>
<body bgcolor="BLACK">
<br>
<% 	try 
	{	
		String typeOfDepreciation = request.getParameter("group1");
		int life = (int)Double.parseDouble(request.getParameter("ulBox"));
		double cost = Double.parseDouble(request.getParameter("costBox"));
		double scrap = Double.parseDouble(request.getParameter("scrapBox"));
		double depreciation = cost-scrap; 
		double accumDepreciation = 0;
		double maxDepreciation = cost-scrap;

		/******************************
		** variables for sum of years *
		*******************************/
		int sumOfYears = 0;
		int decrementLife = 0;
	
		/******************************************
		** variables for double declining balance *
		*******************************************/
		double fractionValue = 0;
		double depCost = 0;
		
		if (typeOfDepreciation.equals("Units of Production"))
		{	%>
			<jsp:forward page="UnitsOfProduction.jsp" />
	<%	}
		else if (typeOfDepreciation.equals("Sum of Years"))
		{
			sumOfYears = (life * (life + 1)) / 2;
			decrementLife = life;
		}
		else if (typeOfDepreciation.equals("Double Declining Balance"))
		{
			depreciation = cost-scrap;
			fractionValue = 2.0 / life;
			depCost = cost;
		}
		else if (typeOfDepreciation.equals("Straight Line")) 
		{
			depreciation = (cost - scrap) / life;
		}
	
		if (cost > scrap && life > 0 && cost > 0 && scrap > 0) 
		{		%>
			<table width="86%" align="CENTER" cellpadding="15" border="15" bgcolor="CCFFFF">
			<tr>
				<td>
					<center>
						<h1><%= typeOfDepreciation%> Table</h1>
					</center>
				</td>
			</tr>
			</table>	
			<table width="86%"  align="CENTER" cellpadding="10" border="10" cellspacing="5" bgcolor="WHITE">
			<tr>
				<tr align="CENTER">
					<td><h1> Cost:  <%= String.format("$%.2f",cost)%> </h1></td>
					<td><h1> Scrap:  <%= String.format("$%.2f",scrap)%> </h1></td>
					<td><h1> Useful Life:  <%= life%> </h1></td>
				</tr>
				<th><h1>Years</h1></th>
				<th><h1>Depreciation</h1></th>
				<th><h1>Accum.Depreciation</h1></th>
<%			for (int numOfYears = 1; numOfYears <= life; numOfYears++) 
			{
				//******************************
				if(typeOfDepreciation.equals("Sum of Years")) 
				{
					if (decrementLife > 0) {
						depreciation = (((double) decrementLife) / sumOfYears) * maxDepreciation;
						decrementLife--;
					}
					if (accumDepreciation < maxDepreciation) {
						accumDepreciation += depreciation;
					}
				}
				else if(typeOfDepreciation.equals("Double Declining Balance")) 
				{
					depreciation = fractionValue * depCost;
					depCost -= depreciation;
					if ( (accumDepreciation + depreciation)  > maxDepreciation) 
					{
						depreciation = maxDepreciation - accumDepreciation;
					}	    
					accumDepreciation += depreciation;  
				}	
				else if (typeOfDepreciation.equals("Straight Line")) 
				{
					if (accumDepreciation < maxDepreciation) 
					{
						accumDepreciation += depreciation;
					}		
				}
				out.write( "<tr align=\"CENTER\"><td>" + numOfYears + "</td><td>"
						+ String.format("$%.2f",depreciation) + "</td><td>"
						+ String.format("$%.2f",accumDepreciation) + "</td></tr>");
			}	%>
			</table>
<%		} 
		else { %>
			<table width="86%"  align="CENTER" cellpadding="10" border="2" cellspacing="5" bgcolor="FF9999">
				<tr align="CENTER"><td>
					<h1> 
					<%= cost <= scrap ? "ERROR!!! Scrap cannot exceed or be equal to Cost" : "No values can be negative or equal to zero!" %>
					</h1>
				</td></tr>
				<tr align="CENTER"><td><h1> Please start over! </h1></td></tr>
			</table>
<%		}
	} 
	catch (NumberFormatException nfe) 
	{ 	%>
		<table width="86%"  align="CENTER" cellpadding="10" border="2" cellspacing="5" bgcolor="FF9999">
			<tr align="CENTER"><td><h1>Invalid Data! Please try again!</h1></td></tr>
		</table>
<%	}
	catch (NullPointerException npe) 
	{ 	%>
		<table width="86%"  align="CENTER" cellpadding="10" border="2" cellspacing="5" bgcolor="FF9999">
			<tr align="CENTER"><td><h1>You must select a type of depreciation. Please try again!</h1></td></tr>
		</table>
<%	} 	%>
	<table width="86%"  align="CENTER" cellpadding="10" border="2" cellspacing="5" bgcolor="0099CC">	
		<form action= "DepreciatingAsset.html" method="POST">
			<tr align="CENTER"><td><input type="submit" class="btn-style" value="Start-Over"></td></tr>
		</form>
	</table>
</body>
</html>
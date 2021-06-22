#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
echo "<html>
<title>Test</title>
<style>
.styled-table {
    border-collapse: collapse;
    margin: 25px 0;
    font-size: 0.9em;
    font-family: sans-serif;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}
.styled-table thead tr {
    background-color: #009879;
    color: #ffffff;
    text-align: left;
}
.styled-table th,
.styled-table td {
    padding: 12px 15px;
}
.styled-table tbody tr {
    border-bottom: 1px solid #dddddd;
}
.styled-table tbody tr:nth-of-type(even) {
    background-color: #f3f3f3;
}

.styled-table tbody tr:last-of-type {
    border-bottom: 2px solid #009879;
}
.styled-table tbody tr.active-row {
    font-weight: bold;
    color: #009879;
}
</style>
<body>
<h1>Welcome to my site guys!</h1>
<table class="styled-table">
    <thead>
        <tr>
			<th>Id</th>
            <th>First Name</th>
            <th>Last Name</th>
			<th>Points</th>
        </tr>
    </thead>
    <tbody>
        <tr>
			<td>1</td>
            <td>Grachya</td>
			<td>Oganesya</td>
            <td>6000</td>
        </tr>
        <tr class="active-row">
			<td>2</td>
            <td>Hrach</td>
			<td>Hovhannisyan</td>
            <td>5150</td>
        </tr>
		<tr>
			<td>3</td>
			<td>Hovhannes</td>
			<td>Hovhannisyan</td>
			<td>9040</td>
		</td>
    </tbody>
</table>
</body>
</html>" | sudo tee /var/www/html/index.html
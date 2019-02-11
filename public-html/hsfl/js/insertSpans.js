$(document).ready(function(){
	document.getElementById("radGrantType").getElementsByTagName('tr')[0].getElementsByTagName('td')[0].innerHTML = document.getElementById("radGrantType").getElementsByTagName('tr')[0].getElementsByTagName('td')[0].innerHTML+ " <span>Note: Applications are due by June 30. Grants will be awarded in October.</span>";

	document.getElementById("radGrantType").getElementsByTagName('tr')[1].getElementsByTagName('td')[0].innerHTML = document.getElementById("radGrantType").getElementsByTagName('tr')[1].getElementsByTagName('td')[0].innerHTML+ " <span>Note: Applications are accepted on a rolling basis. All grant requests will be answered before the Date Funding would be required.</span>";
});
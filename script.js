const dropdownBtns = document.querySelectorAll('.dropdown-btn');

dropdownBtns.forEach(btn => {
  btn.addEventListener('click', function() {
    const dropdownContent = this.nextElementSibling;
    if (dropdownContent.style.display === 'block') {
      dropdownContent.style.display = 'none';
    } else {
      dropdownContent.style.display = 'block';
    }
  });
});
function ConFunction() {
var CSearch = document.getElementById('ConSearch').value
window.open("https://confluence.acceleratedpay.com/dosearchsite.action?queryString=" + CSearch);
}

function Directories() {
    var x = document.getElementById("DirectoryList").value;
if (x=="") demo.value = ""
else if (x=="AP (RCM Upgrade)") demo.value = "5473"
else if (x=="Client Care") demo.value = "5487"
else if (x=="Global Payments Canada") demo.value = "800-263-2970"
else if (x=="Global Payments Customer Service") demo.value = "800-367-2638 Opt 4-4"
else if (x=="Global Payments Standalone Terminal") demo.value = "800-367-2638 Opt 3-2"
else if (x=="Implementations") demo.value = "5424"
else if (x=="Sales") demo.value = "5407"
else if (x=="Tier 2") demo.value = "5432"

}

function addResultsToFinalNotes() {
  const accountName = document.getElementById('accountName').value;
  const processingAccount = document.getElementById('processingAccount').value;
  const contactName = document.getElementById('contactName').value;
  const newContact = document.getElementById('newContact').checked ? '(Added on this call)' : "";
  const contactRole = document.getElementById('contactRole').value;
  const phone = document.getElementById('phone').checked ? 'Business Phone\n' : "";
  const dba = document.getElementById('dba').checked ? 'Business Name\n' : "";
  const address = document.getElementById('address').checked ? 'Business Address\n' : "";
  const caseCheck = document.getElementById('case').checked ? 'Case Number\n' : "";
  const mid = document.getElementById('mid').checked ? 'Merchant ID\n' : "";
  const xweb = document.getElementById('xweb').checked ? 'Xweb ID' : "";
  const ftid = document.getElementById('ftid').checked ? 'Federal Tax ID\n' : "";
  const ssn = document.getElementById('ssn').checked ? 'Last 4 Digits of SSN\n' : "";
  const bank = document.getElementById('bank').checked ? 'Last 4 Digits of Bank Account In MAS' : "";
  const computerName = document.getElementById('computerName').value;
  const os = document.getElementById('os').value;
  const partner = document.getElementById('partner').value;
  const partnerProduct = document.getElementById('partnerProduct').value;
  const productVersion = document.getElementById('productVersion').value;
  const integrationType = document.getElementById('integrationType').value;
  const reasonCalling = document.getElementById('reason-calling').value;
  const stepsTaken = document.getElementById('steps-taken').value;
  const nextSteps = document.getElementById('next-steps').value;
  const References = document.getElementById('reference').value; 
  const offerCaseNumber = document.getElementById('offer-case-number').checked ? 'Offered Case Number' : "";
  const saveToFile = document.getElementById('save-case-to-file').checked;  
let finalNotes = `Account Name: ${accountName}\nProcessing Account: ${processingAccount}\nContact Name: ${contactName} ${newContact}\nContact Role: ${contactRole}\n\nVerified With:\nLevel 1:\n${phone}${dba}${address}${caseCheck}${mid}${xweb}\nLevel 2:\n${ftid}${ssn}${bank}\n\nComputer Name: ${computerName}\nOS: ${os}\n\nPOS Info:\nPartner- ${partner}\nPartner Product- ${partnerProduct}\nProduct Version- ${productVersion}\nIntegration Type- ${integrationType}\n\nReason for Calling: ${reasonCalling}\nSteps Taken:\n${stepsTaken}\nNext Steps:\n${nextSteps}\nReference:\n${References}\n${offerCaseNumber}\n- Close call\n- No Further Assistance Required`;  
  document.getElementById('final-notes').value = finalNotes;
  copyToClipboard(finalNotes)
  
  if (saveToFile) {
    downloadTextarea();
  }
}
function copyToClipboard(text) {
    var dummy = document.createElement("textarea");
    document.body.appendChild(dummy);
    dummy.value = text;
    dummy.select();
    document.execCommand("copy");
    document.body.removeChild(dummy);
}

function downloadTextarea() {
  const finalNotes = document.getElementById('final-notes').value;
  const fileName = document.getElementById('fileName').value;
  const blob = new Blob([finalNotes], { type: 'text/plain' });
  const link = document.createElement('a');
  link.href = URL.createObjectURL(blob);
  link.download = fileName + '.txt';
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}

function clearForm() {
  const formElements = document.querySelectorAll('form input:not(#fileName):not(#os):not(#integrationType):not(input[value="Clear Form"]), form textarea:not(#fileName), form select:not(#os):not(#integrationType)');
  for (let element of formElements) {
    element.value = '';
  }
}

// Add the partner options object
const partnerOptions = ['IDEXX', 'AdvancedMD Software Inc'];

// Add a function to populate the partnerList datalist
function populatePartnerList() {
  const partnerList = document.getElementById('partnerList');

  for (const option of partnerOptions) {
    const optionElement = document.createElement('option');
    optionElement.value = option;
    partnerList.appendChild(optionElement);
  }
}

const partnerProductOptions = {
  IDEXX: ['Petly Plans', 'Cornerstone', 'Neo'],
  AdvancedMD: ['Patient Kiosk', 'EHR Patient Portal', 'Practice Management', 'Patient Portal', 'Advanced Telemedicine'],
  MD: ['Kiosk', 'Portal', 'Management', 'Portal', 'medicine'],
};

const productVersionOptions = {
  'Petly Plans': ['Version 1.0', 'Version 2.0', 'Version 3.0'],
  'Cornerstone': ['9.1 GA2 (Edge PC) Global', '9.1 GA2 (EdgeExpress Cloud) Global', '8.5 NEXT Global', '8.4 NEXT Global', '9.1 GA2 (EdgeExpress Cloud) Global Canada'],
  'Neo': ['Version A', 'Version B', 'Version C'],
  'Patient Kiosk': ['Version X', 'Version Y', 'Version Z'],
  'EHR Patient Portal': ['Version P', 'Version Q', 'Version R'],
  'Practice Management': ['Version M', 'Version N', 'Version O'],
  'Patient Portal': ['Version S', 'Version T', 'Version U'],
  'Advanced Telemedicine': ['Version Alpha', 'Version Beta', 'Version Gamma'],
};

function updatePartnerProduct() {
  const partnerInput = document.getElementById('partner');
  const partnerProductInput = document.getElementById('partnerProduct');
  const selectedPartner = partnerInput.value;

  // Clear existing options
  const partnerProductList = document.getElementById('partnerProductList');
  partnerProductList.innerHTML = '';

  // Add new options based on selected partner
  const options = partnerProductOptions[selectedPartner] || [];
  for (const option of options) {
    const optionElement = document.createElement('option');
    optionElement.value = option;
    partnerProductList.appendChild(optionElement);
  }

  // Update product versions
  updateProductVersions();
}

function updateProductVersions() {
  const partnerProductInput = document.getElementById('partnerProduct');
  const selectedPartnerProduct = partnerProductInput.value;

  // Clear existing options
  const productVersionList = document.getElementById('productVersionList');
  productVersionList.innerHTML = '';

  // Add new options based on selected partner product
  const options = productVersionOptions[selectedPartnerProduct] || [];
  for (const option of options) {
    const optionElement = document.createElement('option');
    optionElement.value = option;
    productVersionList.appendChild(optionElement);
  }
}
		function extractInformation() {
			let inputText = document.getElementById("casePaste").value;
			let accountNameRegex = /Account Name\n([^\n]*)/;
			let processingAccountRegex = /Processing Account\n([^\n]*)/;
			let contactNameRegex = /Contact Name\n([^\n]*)/;
			let subjectRegex = /Subject\n([^\n]*)/;
			let caseNumberRegex = /Case Number\n([^\n]*)/;
			let accountName = inputText.match(accountNameRegex);
			let processingAccount = inputText.match(processingAccountRegex);
			let contactName = inputText.match(contactNameRegex);
			let subject = inputText.match(subjectRegex);
			let caseNumber = inputText.match(caseNumberRegex);
			if (accountName) document.getElementById("accountName").value = accountName[1];
			if (processingAccount) document.getElementById("processingAccount").value = processingAccount[1];
			if (contactName) document.getElementById("contactName").value = contactName[1];
			if (subject) document.getElementById("reason-calling").value = subject[1];
			if (caseNumber) document.getElementById("fileName").value = caseNumber[1];
		}

		document.addEventListener("DOMContentLoaded", function() {
			let inputBox = document.getElementById("casePaste");
			inputBox.addEventListener("input", extractInformation);
		});


// Add event listeners
document.getElementById('partner').addEventListener('input', updatePartnerProduct);
document.getElementById('partnerProduct').addEventListener('input', updateProductVersions);

// Call the populatePartnerList function on page load
populatePartnerList();
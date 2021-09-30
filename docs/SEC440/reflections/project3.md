## My role - Mitigation

For this project, I took on the responsibility of mitigating the ransomware that Hayley created. I did this with a two pronged approach.

### Wazuh
Wazuh was used as the main method of detecting any sort of malware that appears on the target system. Wazuh normally
is used for vulnerability scanning as well as file integrity monitoring. Wazuh documentation does not recommend scanning the 
whole file system because of how much data it would send to its associated Elastic stack. I was able to get Wazuh to monitor 
a specific directory on both Linux and Windows. Every time a file is modified in either of those directories, the file is hashed
and that hash is sent to Virus Total. If it is detected as malicious, Wazuh alerts the Wazuh Manager so that security teams can
respond as quickly as possible. On linux, Wazuh actually has the capability of doing active response. So when the file is detected
as malicious, it is automatically deleted.

It was a fun experience setting Wazuh up, and I learned a lot about its EDR capabilities. I will bring the knowledge I gained from
implementing this ransomware mitigation into my future roles in the cybersecurity field.

### Areca Backup

To complement the ransomware detection of Wazuh, I chose to use the open source tool Areca to backup important directories on Windows.
At a moments notice, system administrators could utilize this tool to automatically restore any modified or lost files. It can backup
certain directories to save storage space, or the entire disk if that is preferred.


This combo of EDR and backup tools is an effective method at mitigating the threat from malware. If I were to add anything
on to this project I would consider integrating Wazuh with Yara for enhanced malware detection.

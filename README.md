# 🏗️ Project Overview
This project implements a secure Hub‑and‑Spoke network architecture on Microsoft Azure, following real enterprise design patterns.
The Hub VNet centralizes all shared services such as Azure Firewall, Bastion, UDRs, and Log Analytics, while Spoke VNets host isolated workloads like Web and App virtual machines.

This architecture improves security, scalability, and operational control across distributed workloads.

## 🔐 Architecture Components
Hub VNet (Centralized Services)
The Hub VNet acts as the core of the network and contains:

### Azure Firewall  
Provides centralized, stateful traffic filtering and outbound control.

### Azure Bastion  
Enables secure RDP/SSH access to VMs without exposing public IPs.

### User Defined Routes (UDR)  
Forces traffic from spokes to pass through the firewall for inspection.

### Log Analytics Workspace (LAW)  
Collects logs from Firewall, VMs, and NSGs for monitoring and security analysis.

 Spoke VNets (Workload Networks)
Spoke VNet 1 — Web Tier
Hosts the Web VM

Connected to Hub via VNet Peering

Routes outbound traffic through Azure Firewall

Spoke VNet 2 — App Tier
Hosts the App VM

Connected to Hub via VNet Peering

Isolated from Web tier unless explicitly allowed

## 🌐 Network Flow Summary
Traffic originates from Internet / On‑Premises

Enters the Hub VNet

Passes through Azure Firewall for filtering

Routed to the appropriate Spoke VNet

Web/App VMs communicate securely through VNet Peering

All logs are collected in Log Analytics Workspace

## 🚀 Key Features
Zero public IPs on workload VMs

Centralized security using Azure Firewall

Secure remote access with Azure Bastion

Forced tunneling using UDRs

Full observability with Log Analytics

Scalable Hub‑and‑Spoke topology for multi‑tier applications

## 🛠️ Technologies Used
Azure Virtual Network (Hub & Spokes)

Azure Firewall

Azure Bastion

User Defined Routes (UDR)

Log Analytics Workspace

Network Security Groups (NSG)

Virtual Machines (Linux/Windows)

## 🎯 What This Project Demonstrates
Enterprise‑grade network segmentation

Secure workload isolation

Centralized traffic inspection

Azure-native security and monitoring

Real‑world cloud architecture design

## 📄 Use Cases
Multi‑tier applications (Web → App → DB)

Secure hybrid connectivity

Centralized security enforcement

Scalable enterprise network design

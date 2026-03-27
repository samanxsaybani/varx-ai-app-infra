# Generative AI Chat Application - Infrastructure as Code

## Overview

This Terraform module provisions a complete infrastructure for a Generative AI Chat Application leveraging Azure's AI services with GPT-4 Turbo model. The infrastructure is designed to be cloud-native, scalable, and secure.

## Architecture Components

### Core Services

| Component | Purpose | Details |
|-----------|---------|---------|
| **Azure OpenAI Service** | AI Model Hosting | GPT-4 Turbo deployment for chat intelligence |
| **App Service** | Web Application Hosting | Linux-based web server for chat UI/API |
| **Azure SQL Database** | Chat History & Users | Persistent storage for conversations and user data |
| **Storage Account** | File & Log Storage | Blob storage for uploads, logs, and file artifacts |
| **Key Vault** | Secrets Management | Secure storage for API keys and credentials |
| **Application Insights** | Monitoring & Analytics | Performance monitoring and diagnostics |
| **Azure AI Services** | Content Moderation | Additional AI capabilities for content safety |

## Directory Structure
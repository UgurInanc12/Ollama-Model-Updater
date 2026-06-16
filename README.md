# Ollama Model Updater

A simple PowerShell script that updates all locally installed Ollama models by running `ollama pull` for each model.

The script lists your local Ollama models, updates them one by one, reports any detected problem, and waits for a key press before closing so the user can see the final result.

## Features

* Updates all locally installed Ollama models
* Detects if Ollama is not installed or not available in PATH
* Shows clear error messages when a model update fails
* Uses colored output for success and error messages
* Waits for a key press before closing
* Simple, lightweight, and dependency-free

## Requirements

* Windows
* PowerShell
* Ollama installed and available in PATH

## Usage

Download or clone this repository, then run the script with PowerShell:

```powershell
.\Update-OllamaModels.ps1
```

If PowerShell execution policy blocks the script, you can run it with:

```powershell
powershell -ExecutionPolicy Bypass -File .\Update-OllamaModels.ps1
```

## Example Output

```text
Updating model: llama3.2:latest
pulling manifest
success
--
Updating model: gemma3:latest
pulling manifest
success
--

Everything updated or already been updated. Please click any key to exit :)
```

If a problem is detected, the script will show an error message before closing:

```text
Problem detected: Failed to update model: example-model
Please click any key to exit :)
```

## Notes

This script updates Ollama models, not the Ollama application itself.

It works by reading the output of:

```powershell
ollama list
```

Then it runs:

```powershell
ollama pull <model>
```

for each local model.

## License

The Unlicense

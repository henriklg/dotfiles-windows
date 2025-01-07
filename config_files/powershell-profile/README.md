# PowerShell Profile Optimization

This project contains an optimized PowerShell profile setup that enhances the startup performance of your PowerShell sessions by organizing aliases and functions into separate files.

## Project Structure

```
powershell-profile
├── profile.ps1      # Main PowerShell profile that loads aliases and functions
├── aliases.ps1      # Contains all alias definitions
├── functions.ps1    # Contains custom function definitions
└── README.md        # Documentation for the project
```

## Setup Instructions

1. **Clone the Repository**: Clone this repository to your local machine.

2. **Load the Profile**: To use the optimized profile, add the following line to your `Microsoft.PowerShell_profile.ps1` file:
   ```powershell
   . "$HOME\path\to\your\powershell-profile\profile.ps1"
   ```

3. **Edit the Profile**: Customize the `aliases.ps1` and `functions.ps1` files as needed to add your own aliases and functions.

## Performance Improvements

- **Separation of Concerns**: By splitting aliases and functions into their own files, the main profile loads faster and is easier to maintain.
- **Dot-Sourcing**: The profile uses dot-sourcing to load the `aliases.ps1` and `functions.ps1` files, which is efficient for loading scripts in the current scope.

## Additional Notes

- Ensure that the paths in `profile.ps1` correctly point to the `aliases.ps1` and `functions.ps1` files.
- You can add more aliases and functions as needed by editing the respective files.
- For further performance tuning, consider reviewing the startup scripts and removing any unnecessary commands.

Enjoy your optimized PowerShell experience!
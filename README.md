# Energy Expenditure Calculator

This is a Shiny web application that calculates energy expenditure using multiple formulas. It provides estimates for Total Daily Energy Expenditure (TDEE), Basal Metabolic Rate (BMR), and macronutrient breakdown based on user inputs.

## Features
- Users can input their weight, height, age, gender, and activity level.
- Calculates energy expenditure using the following formulas:
  - Harris-Benedict Formula
  - Roza Shizgal Formula
  - Mifflin-St Jeor Formula
  - Katch-McArdle Formula
  - Cunningham Formula
- Displays the average TDEE and BMR values across all formulas.
- Provides macronutrient breakdown (protein, fat, carbs) based on the calculated TDEE.

## Installation

To run this application, you need R and the following R packages installed:

- `shiny`
- `bslib`

You can install these packages using the following commands:

```R
install.packages("shiny")
install.packages("bslib")
```

## Running the Application

To run the application, use the following command in R:

```R
shiny::runApp("path/to/your/app.R")
```
Replace `"path/to/your/app.R"` with the actual path to the `app.R` file.

## Input Data

The application requires the following inputs:

- **Weight (kg)**: The weight of the user in kilograms.
- **Height (cm)**: The height of the user in centimeters.
- **Age (years)**: The age of the user in years.
- **Gender**: The gender of the user (Male or Female).
- **Activity Level**: A value between 1.2 and 2.5 representing the user's activity level.

## Formulas Used

- **Harris-Benedict Formula**: A widely used formula to estimate BMR and TDEE.
- **Roza Shizgal Formula**: Adjusts energy requirements based on additional factors.
- **Mifflin-St Jeor Formula**: A more modern formula for estimating BMR.
- **Katch-McArdle Formula**: Takes into account lean body mass for a more accurate BMR.
- **Cunningham Formula**: Similar to Katch-McArdle, focusing on lean body mass.

Each formula's reference link is provided in the app for more detailed information.

## Usage

After inputting the required data, click the "Calculate" button to see the following results:

- **TDEE and BMR for each formula**
- **Average TDEE and BMR values**
- **Macronutrient breakdown** (protein, fat, and carbs) based on the average TDEE

## References
- [Harris-Benedict Formula](https://pmc.ncbi.nlm.nih.gov/articles/PMC1091498/) - A Biometric Study of Human Basal Metabolism
J Arthur Harris, Francis G Benedict
- [Roza Shizgal Formula](https://pubmed.ncbi.nlm.nih.gov/6741850/) - The Harris Benedict equation reevaluated: resting energy requirements and the body cell mass
A M Roza, H M Shizgal
- [Mifflin-St Jeor Formula](https://pubmed.ncbi.nlm.nih.gov/2305711/) - A new predictive equation for resting energy expenditure in healthy individuals
M D Mifflin 1, S T St Jeor, L A Hill, B J Scott, S A Daugherty, Y O Koh
- [Katch-McArdle Formula](https://pubmed.ncbi.nlm.nih.gov/1115020/) - Validity of body composition prediction equations for college men and women
F I Katch, W D McArdle
- [Cunningham Formula](https://pubmed.ncbi.nlm.nih.gov/7435418/) - A reanalysis of the factors influencing basal metabolic rate in normal adults
J J Cunningham

## License
This project is licensed under the MIT License.


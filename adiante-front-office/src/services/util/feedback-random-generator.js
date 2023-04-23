export default function getRandomFeedbackContent(totalFeedbackOptions, localeKey) {

    const randomIndex = Math.floor(Math.random() * totalFeedbackOptions);
    return localeKey+randomIndex;
  }
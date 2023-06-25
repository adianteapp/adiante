export interface SaveAnswersRequest {
    patientId: string;
    executedTask: ExecutedTask;
}

export interface RequestAnswer {
    idQuestion: string;
    answerFreeValue: string;
    idAnswer: string;
}

export interface FilledQuestionnaire {
    idQuestionnaire: string;
    answersList: RequestAnswer[];
}

export interface ExecutedTask {
    idTask: string;
    executed:boolean;
    filledQuestionnaire: FilledQuestionnaire;
}


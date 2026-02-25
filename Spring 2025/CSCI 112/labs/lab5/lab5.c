#include <stdio.h>

#define MAX_QUESTIONS 9
#define MAX_STUDENTS 9

void read_n_chars(char arr[], int n) {
    for (int j = 0; j < n; j++) {
        scanf(" %c", &arr[j]);  
    }
}

void print_n_chars(char arr[], int n) {
    for (int j = 0; j < n; j++) {
        printf("%c ", arr[j]);
    }
    printf("\n");
}

int main(void) {
    int numQuestions, numStudents = 0;
    char correctAnswers[MAX_QUESTIONS];
    int studentIDs[MAX_STUDENTS];
    char studentAnswers[MAX_STUDENTS][MAX_QUESTIONS];
    int missedQuestions[MAX_QUESTIONS] = {0};
    float grades[MAX_STUDENTS];

    scanf("%d", &numQuestions);
    read_n_chars(correctAnswers, numQuestions);

    while (scanf("%d", &studentIDs[numStudents]) != EOF) {
        read_n_chars(studentAnswers[numStudents], numQuestions);
        numStudents++;
    }

    for (int i = 0; i < numStudents; i++) {
        int correctCount = 0;
        for (int j = 0; j < numQuestions; j++) {
            if (studentAnswers[i][j] == correctAnswers[j]) {
                correctCount++;
            } else {
                missedQuestions[j]++;
            }
        }
        grades[i] = (correctCount / (float)numQuestions) * 100;
    }

    printf("Question :");
    for (int i = 0; i < numQuestions; i++) {
        printf(" %d", i + 1);
    }
    printf("\nAnswer   : ");
    print_n_chars(correctAnswers, numQuestions);


    printf("ID    Grade(%%)\n");
    for (int i = 0; i < numStudents; i++) {
        printf("%-5d %5.2f\n", studentIDs[i], grades[i]);
    }

    printf("Question :");
    for (int i = 0; i < numQuestions; i++) {
        printf(" %d", i + 1);
    }
    printf("\nMissed by:");
    for (int i = 0; i < numQuestions; i++) {
        printf(" %d", missedQuestions[i]);
    }
    printf("\n");

    return 0;
}


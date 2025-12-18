CC = gcc
CFLAGS = -Wall -g
LEX = flex
YACC = bison

# Répertoires
SRC_DIR = src
BUILD_DIR = build

# Nom de l'exécutable
TARGET = compiler

# Fichiers sources
LEXER = $(SRC_DIR)/lexer.l
PARSER = $(SRC_DIR)/parser.y

# Fichiers générés
LEX_C = $(BUILD_DIR)/lex.yy.c
PARSER_C = $(BUILD_DIR)/parser.tab.c
PARSER_H = $(BUILD_DIR)/parser.tab.h

# Fichiers objets
OBJS = $(BUILD_DIR)/lex.yy.o $(BUILD_DIR)/parser.tab.o

all: $(BUILD_DIR) $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -lm
	@echo "✓ Compilation réussie : $(TARGET)"

$(LEX_C): $(LEXER) $(PARSER_H)
	$(LEX) -o $(LEX_C) $(LEXER)

$(PARSER_C) $(PARSER_H): $(PARSER)
	$(YACC) -d -o $(PARSER_C) $(PARSER)

$(BUILD_DIR)/lex.yy.o: $(LEX_C)
	$(CC) $(CFLAGS) -I$(BUILD_DIR) -c $< -o $@

$(BUILD_DIR)/parser.tab.o: $(PARSER_C)
	$(CC) $(CFLAGS) -I$(BUILD_DIR) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR) $(TARGET)
	@echo "✓ Nettoyage terminé"

run: $(TARGET)
	./$(TARGET)

test: $(TARGET)
	./$(TARGET) test.txt

.PHONY: all clean run test
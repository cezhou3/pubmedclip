#!/bin/bash

# # Set paths
# TRAINPATH=/workspace/data/VQA_RAD/
# VALPATH=/path/to/ROCO/validation
# TESTPATH=/path/to/ROCO/test
# JSONPATH=./data
# CREATEJSONPROG=./main/create_jsons.py
PRETRAINED_DIR=/workspace/model/PubMedCLIP

# # Create pretrained models directory
# mkdir -p $PRETRAINED_DIR

echo "=========================================="
echo "PubMedCLIP Fine-tuning Script"
echo "=========================================="

# # Create JSON files if they don't exist
# if [ ! -f "$JSONPATH/train_dataset.json" ]; then
#     chmod +x $CREATEJSONPROG
#     echo "Creating json files..."
#     python $CREATEJSONPROG $TRAINPATH $VALPATH $TESTPATH $JSONPATH
# else
#     echo "JSON files already exist, skipping creation..."
# fi

# echo "=========================================="
# echo "Please download pre-trained PubMedCLIP models and place them in $PRETRAINED_DIR/"
# echo "Expected files:"
# echo "  - pubmedclip_vit32.pth (ViT-B/32 model)"
# echo "  - pubmedclip_rn50.pth (ResNet50 model)"
# echo "  - pubmedclip_rn50x4.pth (ResNet50x4 model)"
# echo "Download from: https://huggingface.co/sarahESL/PubMedCLIP"
# echo "=========================================="

# # Check if pretrained models exist
# if [ ! -f "$PRETRAINED_DIR/pubmedclip_vit32.pth" ] && [ ! -f "$PRETRAINED_DIR/pubmedclip_rn50.pth" ]; then
#     echo "Warning: No pre-trained models found in $PRETRAINED_DIR/"
#     echo "Please download the models before proceeding."
#     read -p "Continue anyway? (y/n): " -n 1 -r
#     echo
#     if [[ ! $REPLY =~ ^[Yy]$ ]]; then
#         exit 1
#     fi
# fi

MAINPROG=./main/main.py
chmod +x $MAINPROG

#######***************************##########
# Fine-tune ViT-B/32 model
if [ -f "$PRETRAINED_DIR/PubMedCLIP_ViT32.pth" ]; then
    echo "Fine-tuning PubMedCLIP ViT-B/32 model..."
    CONFIGFILE=./configs/medclip_finetune_vit32.yaml
    python $MAINPROG --cfg $CONFIGFILE --gpu 0
else
    echo "Skipping ViT-B/32 fine-tuning - model not found"
fi

#####################################
# Fine-tune ResNet50 model
if [ -f "$PRETRAINED_DIR/PubMedCLIP_RN50.pth" ]; then
    echo "Fine-tuning PubMedCLIP ResNet50 model..."
    CONFIGFILE=./configs/medclip_finetune_rn50.yaml
    python $MAINPROG --cfg $CONFIGFILE --gpu 0
else
    echo "Skipping ResNet50 fine-tuning - model not found"
fi

echo "=========================================="
echo "Fine-tuning completed!"
echo "Results saved in ./output/medclip_finetune/"
echo "=========================================="

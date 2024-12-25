import os
import sys
from pathlib import Path

def extract_and_rename_images(input_folder, output_folder):
    # Ensure input and output paths are valid
    input_folder = Path(input_folder)
    output_folder = Path(output_folder)

    if not input_folder.is_dir():
        print(f"Error: {input_folder} is not a valid directory.")
        return

    # Use the name of the outermost folder for output naming
    output_subfolder_name = input_folder.name
    output_subfolder = output_folder / output_subfolder_name
    output_subfolder.mkdir(parents=True, exist_ok=True)

    # Initialize counter for renaming
    counter = 0

    # Traverse through the input folder recursively
    for root, _, files in os.walk(input_folder):
        for file in files:
            if file.endswith(".png"):
                # Define source and destination paths
                src_path = Path(root) / file
                dst_path = output_subfolder / f"{counter:02}.png"

                # Copy and rename the file
                src_path.rename(dst_path)
                counter += 1

    print(f"Renamed and moved {counter} files to {output_subfolder}")

if __name__ == "__main__":
    # if len(sys.argv) != 3:
    #     print("Usage: python script.py <input_folder> <output_folder>")
    #     sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = 'exp_images/'

    extract_and_rename_images(input_folder, output_folder)

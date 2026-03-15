# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow contains custom nodes from an unknown_registry and none provide a GitHub aux_id or registry ID,
# so they cannot be auto-installed. Please provide repository information (aux_id) or registry IDs for these
# nodes if you want them installed automatically.
# Could not resolve the following custom nodes (no aux_id / registry info provided):
# - ReferenceLatent
# - FluxGuidance
# - ConditioningZeroOut
# - VAEDecode
# - DualCLIPLoader
# - VAELoader
# - VAEEncode
# - KSampler
# - UNETLoader
# - LoadImage
# - FluxKontextImageScale
# - CLIPTextEncode
# - SaveImage

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/stable-diffusion-3.5-fp8/resolve/main/text_encoders/clip_l.safetensors --relative-path models/clip --filename clip_l.safetensors
RUN comfy model download --url https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors --relative-path models/clip --filename t5xxl_fp16.safetensors
RUN comfy model download --url https://huggingface.co/carlosrozas/ae.safetensors/resolve/main/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/Osrivers/flux1-kontext-dev.safetensors/resolve/main/flux1-kontext-dev.safetensors --relative-path models/diffusion_models --filename flux1-dev-kontext.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/

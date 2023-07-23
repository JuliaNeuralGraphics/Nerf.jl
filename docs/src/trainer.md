# Trainer

Nerf.jl trainer accepts dataset which will be used for training
and a generic NeRF model.
```
using Nerf
using Nerf: Backend, Dataset, BasicModel, BasicField, Trainer
```
Create dataset directly on the `Backend`:
```
config_file = joinpath(pkgdir(Nerf), "data", "raccoon_sofa2", "transforms.json")
dataset = Dataset(Backend; config_file)
```
Create a NeRF model, which in this case is a model from Instant-NGP paper:
```
model = BasicModel(BasicField(Backend))
```
Create trainer by providing `model`, `dataset` and a maximum number of rays
in each training batch:
```
trainer = Trainer(model, dataset; n_rays=1024)
```
After this, training can be done in a loop by calling `Nerf.step!` on a trainer:
```
for i in 1:20_000
    loss = Nerf.step!(trainer)
    @show i, loss
end
```

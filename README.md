# Radial Basis Function Neural Networks for Formation Control of Unmanned Aerial Vehicles
The proposed RBF-BSMC to deal with External Disturbance for a team of Multiple UAVs flying in Formation. This repository presents the following article in MATLAB:

Duy-Nam Bui, and Manh Duong Phung, "**Radial basis function neural networks for formation control of unmanned aerial vehicles**," *Robotica*, 2024. [[**Robotica**](https://doi.org/10.1017/S0263574724000559)] [[Citation](#citation)]

## Citation
```
@article{Bui2024,
  title = {Radial basis function neural networks for formation control of unmanned aerial vehicles},
  ISSN = {1469-8668},
  url = {http://dx.doi.org/10.1017/S0263574724000559},
  DOI = {10.1017/s0263574724000559},
  journal = {Robotica},
  publisher = {Cambridge University Press (CUP)},
  author = {Bui,  Duy-Nam and Phung,  Manh Duong},
  year = {2024},
  month = apr,
  pages = {1–19}
}
```
## Installation
```
git clone git@github.com:duynamrcv/rbf_bsmc.git
```

## Run demo
Firstly, run file `parameter.m` to load the essential parameters. Then open `adaptive.slx` and press `Run` in the simulink.

## Results
### Simulation Results: [video](https://youtu.be/LYD7269n1-c?si=tZ8d34fPaQAHHizl)
#### Scenario 1
| Top view | Side view |
| :---:    |  :---:    |
|<img src="results/rbf-bsmc-traj-top.png" height="420" />|<img src="results/rbf-bsmc-traj-side.png" height="420" /> |

#### Scenario 2
| Top view | 3D view |
| :---:    |  :---:    |
|<img src="results/rbf-bsmc-traj-top2.png" height="400" />|<img src="results/rbf-bsmc-traj-3d2.png" height="400" /> |

### Experiment Results: [video](https://youtu.be/1yUCzWRDcp0?si=hyUxxyt6kPb2hgrZ)


## Generate a Standalone ROS Node from Simulink
To develop and deploy controllers on ROS, please follow this [guideline](https://www.mathworks.com/help/ros/ug/generate-a-standalone-ros-node-from-simulink.html)

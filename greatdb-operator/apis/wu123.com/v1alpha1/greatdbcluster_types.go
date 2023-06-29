/*
Copyright 2023.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// EDIT THIS FILE!  THIS IS SCAFFOLDING FOR YOU TO OWN!
// NOTE: json tags are required.  Any new fields you add must have json tags for the fields to be serialized.

// GreatDBClusterSpec defines the desired state of GreatDBCluster
type GreatDBClusterSpec struct {
	// INSERT ADDITIONAL SPEC FIELDS - desired state of cluster
	// Important: Run "make" to regenerate code after modifying this file

	// Foo is an example field of GreatDBCluster. Edit greatdbcluster_types.go to remove/update
	Foo string `json:"foo,omitempty"`
}

// GreatDBClusterStatus defines the observed state of GreatDBCluster
type GreatDBClusterStatus struct {
	// INSERT ADDITIONAL STATUS FIELD - define observed state of cluster
	// Important: Run "make" to regenerate code after modifying this file
}

//+kubebuilder:object:root=true
//+kubebuilder:subresource:status

// GreatDBCluster is the Schema for the greatdbclusters API
type GreatDBCluster struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   GreatDBClusterSpec   `json:"spec,omitempty"`
	Status GreatDBClusterStatus `json:"status,omitempty"`
}

//+kubebuilder:object:root=true

// GreatDBClusterList contains a list of GreatDBCluster
type GreatDBClusterList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []GreatDBCluster `json:"items"`
}

func init() {
	SchemeBuilder.Register(&GreatDBCluster{}, &GreatDBClusterList{})
}
